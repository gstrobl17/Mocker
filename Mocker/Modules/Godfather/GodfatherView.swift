//
//  GodfatherView.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class GodfatherView {

	var presenter: GodfatherPresenterProtocol?
    let viewController: ViewController
    var activityIndicatorViewController: ActivityIndicatorViewController?

    init(viewController: ViewController) {
        self.viewController = viewController
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
                 contentPresenter: NSViewController) {
        guard viewController.projectFileSelectorView != nil &&
            viewController.sourceFileSelectorView != nil &&
            viewController.sourceFileFilterView != nil &&
            viewController.protocolSelectorView != nil &&
            viewController.mockFileParametersView != nil &&
            viewController.contentPresenterView != nil else { return }   // Added for unit testing
        
        attach(projectFileSelector, to: viewController.projectFileSelectorView)
        attach(sourceFileSelector, to: viewController.sourceFileSelectorView)
        attach(sourceFileFilter, to: viewController.sourceFileFilterView)
        attach(protocolSelector, to: viewController.protocolSelectorView)
        attach(mockFileParameters, to: viewController.mockFileParametersView)
        attach(contentPresenter, to: viewController.contentPresenterView)
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

    func display(_ alert: NSAlert) {
        guard let window = viewController.view.window else { return }
        alert.beginSheetModal(for: window, completionHandler: nil)
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

}
