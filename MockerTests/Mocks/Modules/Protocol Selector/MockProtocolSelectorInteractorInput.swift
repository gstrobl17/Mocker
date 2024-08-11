//
//  MockProtocolSelectorInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import SwiftSyntax

class MockProtocolSelectorInteractorInput: ProtocolSelectorInteractorInputProtocol {

    var presenter: (any ProtocolSelectorInteractorOutputProtocol)?

    func reset() {
    }

}
