//
//  AppDelegate.swift
//  Mocker
//
//  Created by Greg on 2/13/18.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let documentController: MockerDocumentController
    
    @MainActor
    override init() {
        // https://stackoverflow.com/a/7373892
        self.documentController = MockerDocumentController()
        super.init()
    }

    func applicationWillFinishLaunching(_ notification: Notification) {
        let userDefaults = UserDefaults.standard
        let recentDocumentsManager = RecentDocumentManager(userDefaults: userDefaults)
        documentController.recentDocumentManager = recentDocumentsManager
        documentController.userDefaults = userDefaults
        
// Removed due to Sequoia sandbox issue
//        recentDocumentsManager.recents.forEach { documentController.noteNewRecentDocumentURL($0) }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    
    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
//        guard let url = URL(string: filename) else { return false}
//        
//        // This app should have only one open document/window/view controller containing the "Godfather" view
//        guard let window = NSApplication.shared.orderedWindows.first,
//              let viewController = window.contentViewController as? ViewController,
//              let godfatherView = viewController.godfatherView else { return false }
//        
//        // Tell the view to open the recent file
//        godfatherView.openRecentProjectFile(url)
        return true
    }
}
