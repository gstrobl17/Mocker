//
//  SwiftSyntaxHighligher.swift
//  Mocker
//
//  Created by Greg on 3/10/18.
//

// Code adapted from https://github.com/jpsim/SwiftEdit/blob/master/SwiftEdit/SwiftSyntaxHighligher.swift

import Cocoa
import SourceKittenFramework

extension NSAttributedString.Key {
    static let swiftElementType = NSAttributedString.Key(rawValue: "swiftElementType")
}

struct Token {
    let kind: String
    let range: NSRange
}

extension SyntaxKind {
    var colorValue: NSColor {
        switch self {
        case .keyword:
            return NSColor(red: 0.796, green: 0.208, blue: 0.624, alpha: 1)
        case .identifier:
            return .black
        case .typeidentifier:
            return NSColor(red: 0.478, green: 0.251, blue: 0.651, alpha: 1)
        case .string:
            return NSColor(red: 0.918, green: 0.216, blue: 0.071, alpha: 1)
        case .number:
            return NSColor(red: 0.22, green: 0.18, blue: 0.827, alpha: 1)
        case .comment, .commentMark, .commentURL, .docComment, .docCommentField:
            return NSColor(red: 0, green: 0.514, blue: 0.122, alpha: 1)
        case .attributeBuiltin:
            return NSColor(red: 0.796, green: 0.208, blue: 0.624, alpha: 1)
        default:
            return .green
        }
    }
}

class SwiftSyntaxHighligher: NSObject, NSTextStorageDelegate, NSLayoutManagerDelegate {
    let textStorage: NSTextStorage
    let textView: NSTextView
    let scrollView: NSScrollView
    
    init(textStorage: NSTextStorage, textView: NSTextView, scrollView: NSScrollView) {
        self.textStorage = textStorage
        self.scrollView = scrollView
        self.textView = textView
        super.init()
        
        textStorage.delegate = self
        parse()
    }
    
    func visibleRange() -> NSRange {
        guard let container = textView.textContainer, let layoutManager = textView.layoutManager else { return NSRange() }
        let glyphRange = layoutManager.glyphRange(forBoundingRect: scrollView.contentView.bounds, in: container)
        return layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
    }
    
    func parse() {
        guard let tokens = parseString(string: textStorage.string) else {
            return
        }
        
        let range = visibleRange()
        let layoutManagerList = textStorage.layoutManagers as [NSLayoutManager]
        for layoutManager in layoutManagerList {
            layoutManager.delegate = self
            layoutManager.removeTemporaryAttribute(.swiftElementType,
                                                   forCharacterRange: range)
            
            for token in tokens {
                layoutManager.addTemporaryAttributes([.swiftElementType: token.kind],
                                                     forCharacterRange: token.range)
            }
        }
    }
    
    func parseString(string: String) -> [Token]? {
        if string.isEmpty {
            return []
        }
        
        do {
            let syntaxMap = try SyntaxMap(file: File(contents: string))
            return syntaxMap.tokens.map { token in
                let location = (token.offset.value > 0) ? token.offset.value - 1 : 0
                return Token(kind: token.type, range: NSRange(location: location, length: token.length.value))
            }
        } catch let error {
            print(error)
            return nil
        }
    }
    
    override func textStorageDidProcessEditing(_ notification: Notification) {
        DispatchQueue.main.async {
            self.parse()
        }
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager,
                       shouldUseTemporaryAttributes attrs: [NSAttributedString.Key: Any] = [:],
                       forDrawingToScreen toScreen: Bool,
                       atCharacterIndex charIndex: Int,
                       effectiveRange effectiveCharRange: NSRangePointer?) -> [NSAttributedString.Key: Any]? {
        if let type = attrs[.swiftElementType] as? String, toScreen {
            if let style = SyntaxKind(rawValue: type)?.colorValue {
                return [NSAttributedString.Key.foregroundColor: style]
            } else {
                print("\(type) is not a valid style")
            }
        }
        return attrs
    }
}
