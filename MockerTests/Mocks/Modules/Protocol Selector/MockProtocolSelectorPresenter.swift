//
//  MockProtocolSelectorPresenter.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import SwiftSyntax

class MockProtocolSelectorPresenter: ProtocolSelectorPresenterProtocol {

    var interactor: (any ProtocolSelectorInteractorInputProtocol)?

    func reset() {
    }

}
