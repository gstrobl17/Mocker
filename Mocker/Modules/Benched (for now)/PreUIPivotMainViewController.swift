//
// Copyright © 2025 FreedomPay. All rights reserved.
//

import Cocoa
import XcodeEditor

class PreUIPivotMainViewController: NSViewController {

    @IBOutlet weak var projectFileSelectorView: NSView! //swiftlint:disable:this private_outlet
    @IBOutlet weak var splitView: NSSplitView!          //swiftlint:disable:this private_outlet
    @IBOutlet weak var sourceFileSelectorView: NSView!  //swiftlint:disable:this private_outlet
    @IBOutlet weak var sourceFileFilterView: NSView!    //swiftlint:disable:this private_outlet
    @IBOutlet weak var protocolSelectorView: NSView!    //swiftlint:disable:this private_outlet
    @IBOutlet weak var mockFileParametersView: NSView!  //swiftlint:disable:this private_outlet
    @IBOutlet weak var contentPresenterView: NSView!    //swiftlint:disable:this private_outlet
    @IBOutlet weak var copyToClipboardButton: NSButton! //swiftlint:disable:this private_outlet
    @IBOutlet weak var displayChoiceSegmentedControl: NSSegmentedControl! //swiftlint:disable:this private_outlet
    @IBOutlet weak var compareView: NSView!             //swiftlint:disable:this private_outlet
    
    private var windowSetup = false
    private var userDefaults = UserDefaults.standard
    var godfatherView: (any GodfatherViewProtocol & GodfatherInterfaceProtocol)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitView.delegate = self
        
//        godfatherView = GodfatherRouter.createModule(
//            viewController: self,
//            userDefaults: userDefaults,
//            fileManager: FileManager.default,
//            dataSourceFactory: SourceFileDataSourceFactory(),
//            mockGeneratorFactory: ASTMockGeneratorFactory(),
//            openPanelFactory: AppKitOpenPanelFactory(),
//            projectFileSelectorRouterType: ProjectFileSelectorRouter.self,
//            sourceFileSelectorRouterType: SourceFileSelectorRouter.self,
//            sourceFileFilterRouterType: FilterRouter.self,
//            protocolSelectorRouterType: ProtocolSelectorRouter.self,
//            mockFileParametersRouterType: MockFileParametersRouter.self,
//            contentPresenterRouterType: ContentPresenterRouter.self,
//            compareRouterType: CompareRouter.self,
//            filteringHandler: ProjectFilteringHandler(),
//            recentDocumentManager: RecentDocumentManager(userDefaults: userDefaults),
//            documentController: MockerDocumentController.shared
//        )
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
        if menuItem.action == #selector(selectSwiftFile(_:)) {
            return true
        }
        assertionFailure("Unexpected menu item (\(String(describing: menuItem.action))) received in \(#function)")
        return false
    }
    
    @IBAction private func openDocument(_ sender: Any) {
        godfatherView.selectSwiftFile()
    }

    @IBAction private func selectSwiftFile(_ sender: Any) {
        godfatherView.selectSwiftFile()
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

extension PreUIPivotMainViewController: NSSplitViewDelegate {
    
    func splitViewDidResizeSubviews(_ notification: Notification) {
        guard windowSetup else { return }
        userDefaults.leftPaneWidth = sourceFileSelectorView.frame.size.width
    }
    
}
