//
//  AppDelegate.swift
//  Mocker
//
//  Created by Greg on 2/13/18.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    override init() {
        // https://stackoverflow.com/a/7373892
        let recentDocumentsManager = RecentDocumentManager(
            userDefaults: UserDefaults.standard
        )
        let documentController = MockerDocumentController(
            recentDocumentManager: recentDocumentsManager,
            userDefaults: UserDefaults.standard
        )
        super.init()
        
        recentDocumentsManager.recents.forEach { documentController.noteNewRecentDocumentURL($0) }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        guard let url = URL(string: filename) else { return false}
        
        // This app should have only one open document/window/view controller containing the "Godfather" view
        guard let window = NSApplication.shared.orderedWindows.first,
              let viewController = window.contentViewController as? ViewController,
              let godfatherView = viewController.godfatherView else { return false }
        
        // Tell the view to open the recent file
        godfatherView.openRecentProjectFile(url)
        return true
    }
}
