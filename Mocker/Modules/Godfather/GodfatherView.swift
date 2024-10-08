//
//  GodfatherView.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
class GodfatherView {

	var presenter: (any GodfatherPresenterProtocol)?
    let viewController: ViewController
    var activityIndicatorViewController: ActivityIndicatorViewController?

    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func display(_ alert: NSAlert) {
        guard let window = viewController.view.window else { return }
        alert.beginSheetModal(for: window, completionHandler: nil)
    }

}

extension GodfatherView: GodfatherInterfaceProtocol {
    
    func selectProject() {
        presenter?.selectProject()
    }
    
    func canReloadProject() -> Bool {
        presenter?.canReloadProject() ?? false
    }
    
    func reloadProject() {
        presenter?.reloadProject()
    }

    func displayChoice(_ choice: DisplayChoice) {
        presenter?.displayChoice(choice)
    }
    
    func copyMockToClipboard() {
        presenter?.copyMockToClipboard()
    }

    func openRecentProjectFile(_ url: URL) {
        presenter?.openRecentProjectFile(url)
    }
    
}

extension GodfatherView: GodfatherViewProtocol {
    
    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 sourceFileFilter: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController,
                 compare: NSViewController
    ) {
        guard viewController.projectFileSelectorView != nil &&
                viewController.sourceFileSelectorView != nil &&
                viewController.sourceFileFilterView != nil &&
                viewController.protocolSelectorView != nil &&
                viewController.mockFileParametersView != nil &&
                viewController.contentPresenterView != nil &&
                viewController.compareView != nil else { return }   // Added for unit testing
        
        attach(projectFileSelector, to: viewController.projectFileSelectorView)
        attach(sourceFileSelector, to: viewController.sourceFileSelectorView)
        attach(sourceFileFilter, to: viewController.sourceFileFilterView)
        attach(protocolSelector, to: viewController.protocolSelectorView)
        attach(mockFileParameters, to: viewController.mockFileParametersView)
        attach(contentPresenter, to: viewController.contentPresenterView)
        attach(compare, to: viewController.compareView)
    }
    
    private func attach(_ childViewController: NSViewController, to containerView: NSView) {
        viewController.addChild(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childViewController.view)
        childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        childViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        childViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    func reportError(_ error: any Error) {
        let alert = NSAlert(error: error)
        display(alert)
    }
    
    func reportErrorCondition(with messageText: String, and informativeText: String) {
        let alert = NSAlert()
        alert.messageText = messageText
        alert.informativeText = informativeText
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Continue")
        display(alert)
    }
    
    func displayActivityIndicator(_ message: String) {
        guard activityIndicatorViewController == nil else {
            assert(activityIndicatorViewController != nil)
            return
        }
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let viewController = storyboard.instantiateController(withIdentifier: .activityIndicator) as! ActivityIndicatorViewController
        // swiftlint:enable force_cast
        viewController.message = message
        
        self.viewController.presentAsSheet(viewController)
        activityIndicatorViewController = viewController
    }
    
    func closeActivityIndicator() {
        guard let activityIndicatorViewController = activityIndicatorViewController else { return }
        viewController.dismiss(activityIndicatorViewController)
        self.activityIndicatorViewController = nil
    }
    
    func viewHasAppeared() {
        presenter?.viewHasAppeared()
    }

    func enableDisplayChoice(_ flag: Bool) {
        guard let copyToClipboardButton = viewController.copyToClipboardButton else { return }
        guard let displayChoiceSegmentedControl = viewController.displayChoiceSegmentedControl else { return }
        copyToClipboardButton.isEnabled = flag
        displayChoiceSegmentedControl.isEnabled = flag
    }
    
    func setDisplayChoice(_ choice: DisplayChoice) {
        guard let displayChoiceSegmentedControl = viewController.displayChoiceSegmentedControl else { return }
        displayChoiceSegmentedControl.selectedSegment = choice.rawValue
    }

    func displayAsSheet(_ viewController: NSViewController) {
        self.viewController.presentAsSheet(viewController)
    }

    func mockCopiedToClipboard() {
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        guard let copiedViewController = storyboard.instantiateController(withIdentifier: .copiedToPasteboad) as? CopiedToPasteboardViewController,
              let button = viewController.copyToClipboardButton,
              let contentView = NSApp.mainWindow?.contentView else { return }

        let popover = NSPopover()
        popover.contentSize = NSSize(width: 164, height: 22)
        popover.behavior = .transient
        popover.animates = true
        popover.contentViewController = copiedViewController
        
        // Convert point to main window coordinates
        let rect = button.convert(button.bounds, to: contentView)
        
        // Show the popover and close
        popover.show(relativeTo: rect, of: contentView, preferredEdge: .maxY)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            popover.close()
        }
    }

}
