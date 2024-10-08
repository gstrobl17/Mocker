//
//  ProjectFileSelectorViewController.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
class ProjectFileSelectorViewController: NSViewController, ProjectFileSelectorInterfaceProtocol {

    @IBOutlet weak private var projectLabel: NSTextField!
    @IBOutlet weak private var textField: NSTextField!
    @IBOutlet weak private var selectButton: NSButton!
    @IBOutlet weak private var reloadButton: NSButton!
    
    var presenter: (any ProjectFileSelectorPresenterProtocol)?
    weak var delegate: (any ProjectFileSelectorInterfaceDelegate)?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewHasLoaded()
    }
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if menuItem.action == #selector(selectPressed(_:)) {
            return true
        } else if menuItem.action == #selector(reloadPressed(_:)) {
            return presenter?.canReloadProject() ?? false
        }
        assertionFailure("Unexpected menu item (\(String(describing: menuItem.action))) received in \(#function)")
        return false
    }

    @IBAction private func selectPressed(_ sender: Any) {
        presenter?.selectPressed()
    }
    
    func selectProject() {
        selectPressed(self)
    }
    
    @IBAction private func reloadPressed(_ sender: Any) {
        presenter?.reloadPressed()
    }
    
    func canReloadProject() -> Bool {
        presenter?.canReloadProject() ?? false
    }
    
    func reloadProject() {
        reloadPressed(self)
    }

    func renderURLOfSelectedFile(_ url: URL) {
        textField.stringValue = url.path
        presenter?.setURL(url)
    }

}

extension ProjectFileSelectorViewController: ProjectFileSelectorViewProtocol {
    
    func showSelectedFile(_ url: URL) {
        textField.stringValue = url.path
        delegate?.projectFileSelector(self, fileSelected: url)
        presenter?.setURL(url)
    }
    
    func openModalSheet(with openPanel: any OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void) {
        guard let window = view.window else { return }
        openPanel.beginSheetModal(for: window) { response in
            // Let the openPanel close so that the handler can open another sheet.
            DispatchQueue.main.async {
                handler(response)
            }
        }
    }

}
