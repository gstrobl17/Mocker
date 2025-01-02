//
//  SwiftFileSelectorViewController.swift
//  Mocker
//
//  Created Greg on 1/2/25.
//

import AppKit

@MainActor
class SwiftFileSelectorViewController: NSViewController, SwiftFileSelectorInterfaceProtocol {

    @IBOutlet weak private var swiftFileLabel: NSTextField!
    @IBOutlet weak private var textField: NSTextField!
    @IBOutlet weak private var selectButton: NSButton!
    
    var presenter: (any SwiftFileSelectorPresenterProtocol)?
    weak var delegate: (any SwiftFileSelectorInterfaceDelegate)?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewHasLoaded()
    }
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if menuItem.action == #selector(selectPressed(_:)) {
            return true
        }
        assertionFailure("Unexpected menu item (\(String(describing: menuItem.action))) received in \(#function)")
        return false
    }

    @IBAction private func selectPressed(_ sender: Any) {
        presenter?.selectPressed()
    }
    
    func selectSwiftFile() {
        selectPressed(self)
    }

    func renderURLOfSelectedFile(_ url: URL) {
        textField.stringValue = url.path
        presenter?.setURL(url)
    }

}

extension SwiftFileSelectorViewController: SwiftFileSelectorViewProtocol {
    
    func showSelectedFile(_ url: URL) {
        textField.stringValue = url.path
        delegate?.swiftFileSelector(self, fileSelected: url)
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
