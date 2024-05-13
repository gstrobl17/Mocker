//
//  ViewController.swift
//  Mocker
//
//  Created by Greg on 2/13/18.
//

import Cocoa
import XcodeEditor

// https://stackoverflow.com/questions/47051682/unknown-window-class-null-in-interface-builder-file-creating-generic-window-i
class MockerWindow: NSWindow { }

extension NSWindow.FrameAutosaveName {
    static let mockerFrame = UserDefaultsKey.windowFrameAutosaveName
}

class ViewController: NSViewController {

    @IBOutlet weak var projectFileSelectorView: NSView! //swiftlint:disable:this private_outlet
    @IBOutlet weak var splitView: NSSplitView!          //swiftlint:disable:this private_outlet
    @IBOutlet weak var sourceFileSelectorView: NSView!  //swiftlint:disable:this private_outlet
    @IBOutlet weak var sourceFileFilterView: NSView!    //swiftlint:disable:this private_outlet
    @IBOutlet weak var protocolSelectorView: NSView!    //swiftlint:disable:this private_outlet
    @IBOutlet weak var mockFileParametersView: NSView!  //swiftlint:disable:this private_outlet
    @IBOutlet weak var contentPresenterView: NSView!    //swiftlint:disable:this private_outlet
    @IBOutlet weak var copyToClipboardButton: NSButton! //swiftlint:disable:this private_outlet
    @IBOutlet weak var displayChoiceSegmentedControl: NSSegmentedControl! //swiftlint:disable:this private_outlet

    private var windowSetup = false
    private var userDefaults = UserDefaults.standard
    var godfatherView: (GodfatherViewProtocol & GodfatherInterfaceProtocol)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitView.delegate = self
        
        godfatherView = GodfatherRouter.createModule(
            viewController: self,
            userDefaults: userDefaults,
            fileManager: FileManager.default,
            dataSourceFactory: SourceFileDataSourceFactory(),
            mockGeneratorFactory: ASTMockGeneratorFactory(),
            openPanelFactory: AppKitOpenPanelFactory(),
            projectFileSelectorRouterType: ProjectFileSelectorRouter.self,
            sourceFileSelectorRouterType: SourceFileSelectorRouter.self,
            sourceFileFilterRouterType: FilterRouter.self,
            protocolSelectorRouterType: ProtocolSelectorRouter.self,
            mockFileParametersRouterType: MockFileParametersRouter.self,
            contentPresenterRouterType: ContentPresenterRouter.self,
            filteringHandler: ProjectFilteringHandler(),
            recentDocumentManager: RecentDocumentManager(userDefaults: userDefaults),
            documentController: MockerDocumentController.shared
        )
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let window = view.window, let windowController = window.windowController {
            windowController.shouldCascadeWindows = false
            window.setFrameUsingName(.mockerFrame)
            window.setFrameAutosaveName(.mockerFrame)
        }
     
        let leftPaneWidth = UserDefaults.standard.leftPaneWidth
        if let leftPaneWidth = leftPaneWidth {
            splitView.setPosition(leftPaneWidth, ofDividerAt: 0)
        }

        windowSetup = true
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        godfatherView.viewHasAppeared()
    }
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if menuItem.action == #selector(selectProject(_:)) {
            return true
        } else if menuItem.action == #selector(reloadProject(_:)) {
            return godfatherView.canReloadProject()
        }
        assertionFailure("Unexpected menu item (\(String(describing: menuItem.action))) received in \(#function)")
        return false
    }
    
    @IBAction private func openDocument(_ sender: Any) {
        godfatherView.selectProject()
    }

    @IBAction private func selectProject(_ sender: Any) {
        godfatherView.selectProject()
    }
    
    @IBAction private func reloadProject(_ sender: Any) {
        godfatherView.reloadProject()
    }

    @IBAction private func copyToClipboardPressed(_ sender: Any) {
        godfatherView.copyMockToClipboard()
    }
    
    @IBAction private func displayChoiceSegmentedChanged(_ sender: Any) {
        guard let sender = sender as? NSSegmentedControl else { return }
        guard let choice = DisplayChoice(rawValue: sender.selectedSegment) else { return }
        godfatherView.displayChoice(choice)
    }

}

extension ViewController: NSSplitViewDelegate {
    
    func splitViewDidResizeSubviews(_ notification: Notification) {
        guard windowSetup else { return }
        userDefaults.leftPaneWidth = sourceFileSelectorView.frame.size.width
    }
    
}
