//
//  FileSynthesisProtocols.swift
//  Mocker
//
//  Created Greg on 3/2/18.
//

import AppKit
import XcodeEditor

// MARK: Wireframe -
protocol FileSynthesisWireframeProtocol: AnyObject {

    var viewController: NSViewController? { get }
    
    // swiftlint:disable function_parameter_count
    static func createModule(mockName: String,
                             mockCode: String,
                             project: Project,
                             fileSynthesizer: FileSynthesizing,
                             userDefaults: KeyValueStoring,
                             fileManager: FileManaging,
                             destinationGroupSelectorRouterType: DestinationGroupSelectorWireframeProtocol.Type) -> NSViewController
    // swiftlint:enable function_parameter_count

}

// MARK: Presenter -
protocol FileSynthesisPresenterProtocol: AnyObject {

    var interactor: FileSynthesisInteractorInputProtocol? { get set }

    func createPressed()
    func addNewFileToProjectChanged(_ newValue: Bool)
    func viewHasLoaded()
}

// MARK: Interactor -
protocol FileSynthesisInteractorOutputProtocol: AnyObject {

    func install(destinationGroupSelector: NSViewController)
    func groupWasSelected()
    func setAddNewFileToProjectCheckbox(_ flag: Bool)
    func mockFileWasCreated()
    func mockFileCreationFailed(_ error: Error)
    func shouldOverwrite(existingFile name: String) -> Bool
    /* Interactor -> Presenter */
}

protocol FileSynthesisInteractorInputProtocol: AnyObject {

    var presenter: FileSynthesisInteractorOutputProtocol? { get set }
    var group: XCGroup? { get }

    func generateMockFile()
    func addNewFileToProjectChanged(_ newValue: Bool)
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
protocol FileSynthesisViewProtocol: AnyObject {

    var presenter: FileSynthesisPresenterProtocol? { get set }

    func install(destinationGroupSelector: NSViewController)
    func enableCreateButton(_ flag: Bool)
    func setAddNewFileToProjectCheckbox(_ flag: Bool)
    func close()
    func shouldOverwrite(existingFile name: String) -> Bool
    func display(_ alert: NSAlert)
    /* Presenter -> ViewController */
}
