//
//  ProtocolSelectorViewController.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import SwiftSyntax

class ProtocolSelectorViewController: NSViewController {

	var presenter: (any ProtocolSelectorPresenterProtocol)?
    weak var delegate: (any ProtocolSelectorInterfaceDelegate)?
    
    private var protocols = [ProtocolDeclSyntax]() {
        didSet {
            comboBox.reloadData()
        }
    }

    @IBOutlet weak private var comboBox: NSComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comboBox.usesDataSource = true
        comboBox.dataSource = self
        comboBox.delegate = self
    }

}

extension ProtocolSelectorViewController: ProtocolSelectorViewProtocol {
}

extension ProtocolSelectorViewController: ProtocolSelectorInterfaceProtocol {
    
    func present(protocols: [ProtocolDeclSyntax]) {
        self.protocols = protocols
        if protocols.isEmpty {
            comboBox.isEnabled = false
            comboBox.stringValue = ""
        } else {
            comboBox.isEnabled = true
            comboBox.selectItem(at: 0)
        }
    }
    
}

extension ProtocolSelectorViewController: NSComboBoxDelegate {
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let selectedIndex = comboBox.indexOfSelectedItem
        if selectedIndex >= 0 && selectedIndex < protocols.count {
            delegate?.protocolSelector(self, protocolSelected: protocols[selectedIndex])
        }
    }
    
}

extension ProtocolSelectorViewController: NSComboBoxDataSource {
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        protocols.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        protocols[index].name.text
    }
}
