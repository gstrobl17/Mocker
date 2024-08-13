//
//  MockFileParametersInteractor.swift
//  Mocker
//
//  Created Greg on 2/25/18.
//

import AppKit

class MockFileParametersInteractor {

    weak var presenter: MockFileParametersInteractorOutputProtocol? {
        didSet {
            sendParameterValues()
        }
    }
    
    private var userDefaults: KeyValueStoring
    private var protocolName: String = ""

    init(userDefaults: KeyValueStoring) {
        self.userDefaults = userDefaults
    }

    internal var mockFileName: String {
        if self.protocolName.isEmpty {
            return ""
        }
        
        let prefix = userDefaults.mockPrefix.trimmingCharacters(in: .whitespacesAndNewlines)
        let protocolName = self.protocolName.trimmingCharacters(in: .whitespacesAndNewlines)

        let PROTOCOL = "Protocol"
        var processedProtocolName = protocolName
        if userDefaults.stripTrailingProtocol && protocolName.hasSuffix(PROTOCOL) {
            processedProtocolName = String(protocolName.dropLast(PROTOCOL.count))
        }
        let name = prefix + processedProtocolName
        
        return name
    }
    
    private func broadcastMockFileName() {
        presenter?.setName(mockFileName)
    }

    private func sendParameterValues() {
        presenter?.setParameters(prefix: userDefaults.mockPrefix,
                                 includeHeader: userDefaults.includeHeader,
                                 stripTrailingProtocol: userDefaults.stripTrailingProtocol,
                                 includeTestableImport: userDefaults.includeTestableImport,
                                 trackPropertyActivity: userDefaults.trackPropertyActivity,
                                 public: userDefaults.public)
        broadcastMockFileName()
    }
    
}

extension MockFileParametersInteractor: MockFileParametersInteractorInputProtocol {
    
    func setProtocolName(_ protocolName: String) {
        self.protocolName = protocolName
        broadcastMockFileName()
    }
    
    func prefixUpdated(to prefix: String) {
        userDefaults.mockPrefix = prefix
        broadcastMockFileName()
    }
    
    func includeHeaderFlagUpdated(to flag: Bool) {
        userDefaults.includeHeader = flag
    }

    func stripTrailingProtocolFlagUpdated(to flag: Bool) {
        userDefaults.stripTrailingProtocol = flag
        broadcastMockFileName()
    }
    
    func includeTestableImportFlagUpdated(to flag: Bool) {
        userDefaults.includeTestableImport = flag
    }

    func trackPropertyActivityFlagUpdated(to flag: Bool) {
        userDefaults.trackPropertyActivity = flag
    }

    func publicFlagUpdated(to flag: Bool) {
        userDefaults.public = flag
    }
    
    func viewHasLoaded() {
        sendParameterValues()
    }

}
