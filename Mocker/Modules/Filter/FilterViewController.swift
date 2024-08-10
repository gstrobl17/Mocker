//
//  FilterViewController.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit

class FilterViewController: NSViewController {

	var presenter: (any FilterPresenterProtocol)?

    @IBOutlet private weak var textField: NSSearchField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        presenter?.viewHasLoaded()
    }

}

extension FilterViewController: FilterViewProtocol {
    
    func setValue(_ value: String) {
        guard let textField = textField else { return }
        textField.stringValue = value
    }

}

extension FilterViewController: NSSearchFieldDelegate {
    
    func controlTextDidChange(_ notification: Notification) {
        if let textField = notification.object as? NSSearchField {
            //print(textField.stringValue)
            presenter?.filterValueChanged(to: textField.stringValue)
        }
    }
    
}
