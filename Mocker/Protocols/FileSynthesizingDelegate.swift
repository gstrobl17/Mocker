//
//  FileSynthesizingDelegate.swift
//  Mocker
//
//  Created by Strobl, Greg on 3/7/18.
//

import Foundation

protocol FileSynthesizingDelegate: AnyObject {
    func fileSynthesizerShouldOverwrite(_ fileSynthesizer: FileSynthesizing, existingFile name: String) -> Bool
}
