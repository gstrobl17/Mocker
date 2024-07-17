//
//  MockFileParametersViewController.swift
//  Mocker
//
//  Created Greg on 2/25/18.
//

import AppKit
import SwiftSyntax
import XcodeEditor

class MockFileParametersViewController: NSViewController {

	var presenter: MockFileParametersPresenterProtocol?
    weak var delegate: MockFileParametersInterfaceDelegate?

    @IBOutlet weak private var prefixTextField: NSTextField!
    @IBOutlet weak private var stripTrailingProtocolCheckBox: NSButton!
    @IBOutlet weak private var includeTestableImportCheckBox: NSButton!
    @IBOutlet weak private var includeHeaderCheckBox: NSButton!
    @IBOutlet weak private var swiftlintAwareCheckBox: NSButton!
    @IBOutlet weak private var targetsComboBox: NSComboBox!
    @IBOutlet weak private var trackPropertyActivityCheckbox: NSButton!
    @IBOutlet weak private var publicCheckbox: NSButton!
    @IBOutlet weak private var nameTextField: NSTextField!
    
    private var targets = [String]() {
        didSet {
            targetsComboBox.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefixTextField.delegate = self
        targetsComboBox.usesDataSource = true
        targetsComboBox.dataSource = self
        targetsComboBox.delegate = self
        nameTextField.delegate = self
        presenter?.viewHasLoaded()
    }
    
    private func setState() {
        targetsComboBox.isEnabled = (includeTestableImportCheckBox.state == .on) && !targets.isEmpty
    }
 
    private func broadcastParameters() {
        let mockName = nameTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let includeHeader = (includeHeaderCheckBox.state == .on)
        let includeTestableImport = (includeTestableImportCheckBox.state == .on)
        let swiftlintAware = (swiftlintAwareCheckBox.state == .on)
        let testableTargetName = targetsComboBox.stringValue
        let trackPropertyActivity = (trackPropertyActivityCheckbox.state == .on)
        let `public` = (publicCheckbox.state == .on)
        delegate?.mockFileParameters(self,
                                     mockName: mockName,
                                     includeHeader: includeHeader,
                                     includeTestableImport: includeTestableImport,
                                     swiftlintAware: swiftlintAware,
                                     testableTargetName: testableTargetName,
                                     trackPropertyActivity: trackPropertyActivity, 
                                     public: `public`)
    }
    
    @IBAction private func includeHeaderPressed(_ sender: Any) {
        guard let checkBox = sender as? NSButton else { return }
        switch checkBox.state {
        case .on:
            presenter?.includeHeaderFlagUpdated(to: true)
        case .off:
            presenter?.includeHeaderFlagUpdated(to: false)
        default:
            assertionFailure("Unexpected button state")
        }
        setState()
        broadcastParameters()
    }
    
    @IBAction private func stripTrailingProtocolPressed(_ sender: Any) {
        guard let checkBox = sender as? NSButton else { return }
        switch checkBox.state {
        case .on:
            presenter?.stripTrailingProtocolFlagUpdated(to: true)
        case .off:
            presenter?.stripTrailingProtocolFlagUpdated(to: false)
        default:
            assertionFailure("Unexpected button state")
        }
    }
    
    @IBAction private func includeTestableImportPressed(_ sender: Any) {
        guard let checkBox = sender as? NSButton else { return }
        switch checkBox.state {
        case .on:
            presenter?.includeTestableImportFlagUpdated(to: true)
        case .off:
            presenter?.includeTestableImportFlagUpdated(to: false)
        default:
            assertionFailure("Unexpected button state")
        }
        setState()
        broadcastParameters()
    }
   
    @IBAction private func swiftlintAwarePressed(_ sender: Any) {
        guard let checkBox = sender as? NSButton else { return }
        switch checkBox.state {
        case .on:
            presenter?.swiftlintAwareFlagUpdated(to: true)
        case .off:
            presenter?.swiftlintAwareFlagUpdated(to: false)
        default:
            assertionFailure("Unexpected button state")
        }
        setState()
        broadcastParameters()
    }
    
    @IBAction private func targetSelected(_ sender: Any) {
        broadcastParameters()
    }
    
    @IBAction private func trackPropertyActivityPressed(_ sender: Any) {
        guard let checkBox = sender as? NSButton else { return }
        switch checkBox.state {
        case .on:
            presenter?.trackPropertyActivityFlagUpdated(to: true)
        case .off:
            presenter?.trackPropertyActivityFlagUpdated(to: false)
        default:
            assertionFailure("Unexpected button state")
        }
        setState()
        broadcastParameters()
    }
    
    @IBAction private func publicPressed(_ sender: Any) {
        guard let checkBox = sender as? NSButton else { return }
        switch checkBox.state {
        case .on:
            presenter?.publicFlagUpdated(to: true)
        case .off:
            presenter?.publicFlagUpdated(to: false)
        default:
            assertionFailure("Unexpected button state")
        }
        setState()
        broadcastParameters()
    }
}

extension MockFileParametersViewController: MockFileParametersViewProtocol {
    
    //swiftlint:disable:next function_parameter_count cyclomatic_complexity
    func setParameters(prefix: String,
                       includeHeader: Bool,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool,
                       public: Bool) {
        guard prefixTextField != nil else { return }    // Added for unit testing
        prefixTextField.stringValue = prefix
        switch includeHeader {
        case true:
            includeHeaderCheckBox.state = .on
        case false:
            includeHeaderCheckBox.state = .off
        }
        switch stripTrailingProtocol {
        case true:
            stripTrailingProtocolCheckBox.state = .on
        case false:
            stripTrailingProtocolCheckBox.state = .off
        }
        switch swiftlintAware {
        case true:
            swiftlintAwareCheckBox.state = .on
        case false:
            swiftlintAwareCheckBox.state = .off
        }
        switch includeTestableImport {
        case true:
            includeTestableImportCheckBox.state = .on
        case false:
            includeTestableImportCheckBox.state = .off
        }
        switch trackPropertyActivity {
        case true:
            trackPropertyActivityCheckbox.state = .on
        case false:
            trackPropertyActivityCheckbox.state = .off
        }
        switch `public` {
        case true:
            publicCheckbox.state = .on
        case false:
            publicCheckbox.state = .off
        }
        setState()
    }
    
    func setName(_ name: String) {
        guard nameTextField != nil else { return }    // Added for unit testing
        nameTextField.stringValue = name
        broadcastParameters()
    }
    
}

extension MockFileParametersViewController: MockFileParametersInterfaceProtocol {
    
    func setup(for protocolDeclaration: ProtocolDeclSyntax) {
        presenter?.setProtocolName(protocolDeclaration.name.text)
    }
    
    func setup(for dataSource: SourceFileDataSource) {
        self.targets = dataSource.targets
    
        if self.targets.isEmpty {
            targetsComboBox.stringValue = ""
        } else {
            targetsComboBox.selectItem(at: 0)
        }
        setState()
    }
    
    func setup(for specificTarget: String) {
        for (index, target) in targets.enumerated() where specificTarget == target {
            targetsComboBox.selectItem(at: index)
            setState()
            break
        }
    }
    
    func clearProtocol() {
        presenter?.setProtocolName("")
    }
    
}

extension MockFileParametersViewController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ notification: Notification) {
        if let textField = notification.object as? NSTextField {
            if textField === prefixTextField {
                presenter?.prefixUpdated(to: textField.stringValue)
            } else if textField === nameTextField {
                broadcastParameters()
            }
        }
    }
    
}

extension MockFileParametersViewController: NSComboBoxDelegate {
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        broadcastParameters()
    }
    
}

extension MockFileParametersViewController: NSComboBoxDataSource {
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        targets.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        targets[index]
    }
}
