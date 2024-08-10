//
//  FilterInteractor.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit

//
// If this is used for more than filtering the source file,
//  the use of user defaults will have to be changed to not
//  directly store data in userDefaults.sourceFileFilterValue
//

class FilterInteractor {

    weak var presenter: (any FilterInteractorOutputProtocol)? {
        didSet {
            sendValue()
        }
    }
    weak var delegate: (any FilterInterfaceDelegate)?
    
    private var userDefaults: any KeyValueStoring

    init(userDefaults: any KeyValueStoring) {
        self.userDefaults = userDefaults
    }

    private func sendValue() {
        guard let presenter = presenter else { return }
        let value = userDefaults.sourceFileFilterValue ?? ""
        presenter.setValue(value)
    }
}

extension FilterInteractor: FilterInteractorInputProtocol {
    
    func viewHasLoaded() {
        sendValue()
    }
    
    func filterValueChanged(to value: String) {
        userDefaults.sourceFileFilterValue = value
        delegate?.filter(self, newValue: value)
    }

}

extension FilterInteractor: FilterInterfaceProtocol {

    func clear() {
        userDefaults.sourceFileFilterValue = ""
        sendValue()
    }

}
