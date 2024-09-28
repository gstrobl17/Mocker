//
//  BeyondCompareComparisonToolInvoker.swift
//  Mocker
//
//  Created by Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

class BeyondCompareComparisonToolInvoker: ComparisonToolInvoking {

    enum Constant {
        static let executablePath = "/usr/local/bin/bcompare"
        static let leftreadonly = "-leftreadonly"
    }
    
    var delegate: (any ComparisonToolInvokerDelegate)?
    let fileManager: any FileManaging
    
    init(
        fileManager: any FileManaging
    ) {
        self.fileManager = fileManager
    }
    
    func lookForComparisonTool() {
        // I tried to call "which bcompare", but I couldn't make that work.
        // (See commented out code at the bottom of the file.)
        
        // Look for the bcompare execuatable.
        //  If found, return true via the delegate.
        let toolFound = fileManager.fileExists(atPath: Constant.executablePath)
        delegate?.invoker(self, toolFound: toolFound)
    }
    
    func openComparisonTool(for url1: URL, and url2: URL) -> (terminationStatus: Int32, output: String) {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = [Constant.leftreadonly, "\(url1)", "\(url2)"]
        task.executableURL = URL(fileURLWithPath: Constant.executablePath)
        task.standardInput = nil

        do {
            try task.run()
        } catch {
            return (terminationStatus: -1, output: error.localizedDescription)
        }
        
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8) ?? "N/A"

        return (terminationStatus: task.terminationStatus, output: output)
    }

}

/*
 Attempted implementation of lookForComparisonTool() calling "which bcompare"
 It didn't work (it seems) because the environment variables weren't set.
 
 Resulted in the following output:
 
     lookForComparisonTool() 1
     lookForComparisonTool() 2
     lookForComparisonTool() 4
     which bcompare -> [1] [bcompare not found
     ]
 
 func lookForComparisonTool() {
     print("\(#function) 1")
     let task = Process()
     let pipe = Pipe()
     
     task.standardOutput = pipe
     task.standardError = pipe
     task.environment = ProcessInfo.processInfo.environment
     task.arguments = ["-c", "which bcompare"]
     task.executableURL = URL(fileURLWithPath: Constant.shell)
     task.standardInput = nil

     do {
         print("\(#function) 2")
         try task.run()
     } catch {
         print("\(#function) 3")
         print("Calling which bcompare failed: \(error)")
         delegate?.invoker(self, toolFound: false)
         return
     }
     
     task.waitUntilExit()
     print("\(#function) 4")
     let data = pipe.fileHandleForReading.readDataToEndOfFile()
     let output = String(decoding: data, as: UTF8.self)

     print("which bcompare -> [\(task.terminationStatus)] [\(output)]")
 }
 */
