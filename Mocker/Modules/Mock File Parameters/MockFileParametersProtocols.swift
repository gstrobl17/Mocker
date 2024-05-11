//
//  MockFileParametersProtocols.swift
//  Mocker
//
//  Created Greg on 2/25/18.
//

import AppKit
import SwiftSyntax
import XcodeEditor

protocol MockFileParametersInterfaceProtocol: AnyObject {
    var delegate: MockFileParametersInterfaceDelegate? { get set }

    func setup(for protocolDeclaration: ProtocolDeclSyntax)
    func setup(for project: Project)
    func setup(for target: XCTarget)
    func clearProtocol()
}

protocol MockFileParametersInterfaceDelegate: AnyObject {
    func mockFileParameters(_ view: (NSViewController & MockFileParametersInterfaceProtocol),   //swiftlint:disable:this function_parameter_count
                            mockName: String,
                            includeHeader: Bool,
                            includeTestableImport: Bool,
                            swiftlintAware: Bool,
                            testableTargetName: String,
                            trackPropertyActivity: Bool,
                            public: Bool)
}

// MARK: Wireframe -
protocol MockFileParametersWireframeProtocol: AnyObject {
    var viewController: (NSViewController & MockFileParametersInterfaceProtocol)? { get }
    
    static func createModule(userDefaults: KeyValueStoring) -> (NSViewController & MockFileParametersInterfaceProtocol)
}

// MARK: Presenter -
protocol MockFileParametersPresenterProtocol: AnyObject {

    var interactor: MockFileParametersInteractorInputProtocol? { get set }
    
    func setProtocolName(_ protocolName: String)
    func prefixUpdated(to prefix: String)
    func includeHeaderFlagUpdated(to flag: Bool)
    func stripTrailingProtocolFlagUpdated(to flag: Bool)
    func swiftlintAwareFlagUpdated(to flag: Bool)
    func includeTestableImportFlagUpdated(to flag: Bool)
    func trackPropertyActivityFlagUpdated(to flag: Bool)
    func publicFlagUpdated(to flag: Bool)

    // Method required because the view is not setup enough when the initial configure call is made
    //  to do the actual installation. This gets called in viewDidLoad when it is ready to perform
    //  the component installation.
    func viewHasLoaded()
    /* ViewController -> Presenter */

}

// MARK: Interactor -
protocol MockFileParametersInteractorOutputProtocol: AnyObject {    //swiftlint:disable:this type_name

    //swiftlint:disable:next function_parameter_count
    func setParameters(prefix: String,
                       includeHeader: Bool,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool,
                       public: Bool)
    func setName(_ name: String)

    /* Interactor -> Presenter */
}

protocol MockFileParametersInteractorInputProtocol: AnyObject { //swiftlint:disable:this type_name

    var presenter: MockFileParametersInteractorOutputProtocol? { get set }

    func setProtocolName(_ protocolName: String)
    func prefixUpdated(to prefix: String)
    func includeHeaderFlagUpdated(to flag: Bool)
    func stripTrailingProtocolFlagUpdated(to flag: Bool)
    func swiftlintAwareFlagUpdated(to flag: Bool)
    func includeTestableImportFlagUpdated(to flag: Bool)
    func trackPropertyActivityFlagUpdated(to flag: Bool)
    func publicFlagUpdated(to flag: Bool)
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
protocol MockFileParametersViewProtocol: AnyObject {

    var presenter: MockFileParametersPresenterProtocol? { get set }

    //swiftlint:disable:next function_parameter_count
    func setParameters(prefix: String,
                       includeHeader: Bool,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool,
                       public: Bool)
    func setName(_ name: String)
    /* Presenter -> ViewController */
}
