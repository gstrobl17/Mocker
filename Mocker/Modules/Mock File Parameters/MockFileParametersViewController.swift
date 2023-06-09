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
    @IBOutlet weak private var swiftlintAwareCheckBox: NSButton!
    @IBOutlet weak private var targetsComboBox: NSComboBox!
    @IBOutlet weak private var trackPropertyActivityCheckbox: NSButton!
    @IBOutlet weak private var nameTextField: NSTextField!
    
    private var targets = [XCTarget]() {
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
        let includeTestableImport = (includeTestableImportCheckBox.state == .on)
        let swiftlintAware = (swiftlintAwareCheckBox.state == .on)
        let testableTargetName = targetsComboBox.stringValue
        let trackPropertyActivity = (trackPropertyActivityCheckbox.state == .on)
        delegate?.mockFileParameters(self,
                                     mockName: mockName,
                                     includeTestableImport: includeTestableImport,
                                     swiftlintAware: swiftlintAware,
                                     testableTargetName: testableTargetName,
                                     trackPropertyActivity: trackPropertyActivity)
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
}

extension MockFileParametersViewController: MockFileParametersViewProtocol {
    
    func setParameters(prefix: String,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool) {
        guard prefixTextField != nil else { return }    // Added for unit testing
        prefixTextField.stringValue = prefix
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
        presenter?.setProtocolName(protocolDeclaration.identifier.text)
    }
    
    func setup(for project: Project) {
        var newTargets = [XCTarget]()
        if let targets = project.targets() {
            newTargets = targets.filter { $0.nameForCode != nil }
        }
        self.targets = newTargets
    
        if self.targets.isEmpty {
            targetsComboBox.stringValue = ""
        } else {
            targetsComboBox.selectItem(at: 0)
        }
        setState()
    }
    
    func setup(for specificTarget: XCTarget) {
        for (index, target) in targets.enumerated() where specificTarget.nameForCode == target.nameForCode {
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
        targets[index].nameForCode
    }
}
