//
//  FileSynthesisViewController.swift
//  Mocker
//
//  Created Greg on 3/2/18.
//

import AppKit
import XcodeEditor

class FileSynthesisViewController: NSViewController {

	var presenter: FileSynthesisPresenterProtocol?

    @IBOutlet weak private var addNewFileToProjectCheckBox: NSButton!
    @IBOutlet weak private var destinationGroupSelectorView: NSView!
    @IBOutlet weak private var createButton: NSButton!
    @IBOutlet weak private var cancelButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.isEnabled = false
        presenter?.viewHasLoaded()
    }

    @IBAction private func createPressed(_ sender: Any) {
        presenter?.createPressed()
    }
    
    @IBAction private func cancelPressed(_ sender: Any) {
        close()
    }
    
    @IBAction private func addNewFileToProjectPressed(_ sender: Any) {
        let flag = (addNewFileToProjectCheckBox.state == .on)
        presenter?.addNewFileToProjectChanged(flag)
    }
    
}

extension FileSynthesisViewController: FileSynthesisViewProtocol {
    
    func install(destinationGroupSelector: NSViewController) {
        guard destinationGroupSelectorView != nil else { return } // Added for unit testing
        
        addChild(destinationGroupSelector)
        destinationGroupSelector.view.translatesAutoresizingMaskIntoConstraints = false
        destinationGroupSelectorView.addSubview(destinationGroupSelector.view)
        destinationGroupSelector.view.topAnchor.constraint(equalTo: destinationGroupSelectorView.topAnchor).isActive = true
        destinationGroupSelector.view.leadingAnchor.constraint(equalTo: destinationGroupSelectorView.leadingAnchor).isActive = true
        destinationGroupSelector.view.trailingAnchor.constraint(equalTo: destinationGroupSelectorView.trailingAnchor).isActive = true
        destinationGroupSelector.view.bottomAnchor.constraint(equalTo: destinationGroupSelectorView.bottomAnchor).isActive = true
    }

    func enableCreateButton(_ flag: Bool) {
        guard createButton != nil else { return }
        createButton.isEnabled = flag
    }
    
    func setAddNewFileToProjectCheckbox(_ flag: Bool) {
        guard addNewFileToProjectCheckBox != nil else { return }
        switch flag {
        case true:
            addNewFileToProjectCheckBox.state = .on
        case false:
            addNewFileToProjectCheckBox.state = .off
        }
    }

    func close() {
        dismiss(self)
    }
    
    func shouldOverwrite(existingFile name: String) -> Bool {
        let prompt = NSAlert()
        prompt.messageText = "\(name) exists. Overwrite?"
        prompt.addButton(withTitle: "Overwrite")
        prompt.addButton(withTitle: "Cancel")
        
        let response = prompt.runModal()
        let overwrite = (response == .alertFirstButtonReturn)
        return overwrite
    }

    func display(_ alert: NSAlert) {
        guard let window = view.window else { return }
        alert.beginSheetModal(for: window, completionHandler: nil)
    }

}

