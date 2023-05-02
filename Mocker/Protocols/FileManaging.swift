//
//  FileManaging.swift
//  Mocker
//
//  Created by Greg on 2/25/18.
//

import Foundation

protocol FileManaging {
    
    func fileExists(atPath path: String) -> Bool
    
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws

    func removeItem(atPath path: String) throws
}
