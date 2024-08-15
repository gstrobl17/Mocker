//
//  ContentPresenterViewController.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
class ContentPresenterViewController: NSViewController {

    var syntaxHighlighter: SwiftSyntaxHighligher?

    @IBOutlet private weak var scrollView: NSScrollView!
    @IBOutlet private weak var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = NSFont(name: "Menlo", size: NSFont.systemFontSize) ?? NSFont.systemFont(ofSize: NSFont.systemFontSize, weight: .regular)
        textView.font = font
        textView.textContainer?.widthTracksTextView = false
        textView.textContainer?.lineBreakMode = .byClipping
        textView.textContainer?.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        if let textStorage = textView.textStorage {
            syntaxHighlighter = SwiftSyntaxHighligher(textStorage: textStorage, textView: textView, scrollView: scrollView)
        }
    }

}

extension ContentPresenterViewController: ContentPresenterInterfaceProtocol {
 
    func present(text: String?) {
        textView.string = text ?? ""
    }
    
}
