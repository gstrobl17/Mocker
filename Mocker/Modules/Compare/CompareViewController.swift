//
//  CompareViewController.swift
//  Mocker
//
//  Created Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

class CompareViewController: NSViewController {

	var presenter: (any ComparePresenterProtocol)?
    weak var delegate: (any CompareInterfaceDelegate)?

    // Start with the button hidden. If comparison tool is found, button will be made visible.
    private(set) var isButtonHidden = false

    @IBOutlet weak private var compareButton: NSButton! {
        didSet {
            if let compareButton {
                compareButton.isHidden = isButtonHidden
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareButton.isHidden = isButtonHidden
    }

    @IBAction private func comparePressed(_ sender: Any) {
        presenter?.compareButtonPressed()
    }
    
    func display(_ alert: NSAlert) {
        guard let window = view.window else { return }
        alert.beginSheetModal(for: window, completionHandler: nil)
    }

}

extension CompareViewController: CompareViewProtocol {

    func showButton(_ flag: Bool) {
        isButtonHidden = !flag
        guard let compareButton else { return }
        compareButton.isHidden = isButtonHidden
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
    
    func reportErrorCondition(with messageText: String, and informativeText: String) {
        let alert = NSAlert()
        alert.messageText = messageText
        alert.informativeText = informativeText
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Continue")
        display(alert)
    }

    func mockCodeForCompare() -> String {
        delegate?.mockCodeForCompare(self) ?? ""
    }
}

extension CompareViewController: CompareInterfaceProtocol {
    
    func enableCompare(_ flag: Bool) {
        guard let compareButton else { return }
        compareButton.isEnabled = flag
    }

}
