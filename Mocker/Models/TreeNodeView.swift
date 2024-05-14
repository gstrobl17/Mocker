//
//  TreeNodeView.swift
//  Mocker
//
//  Created by Greg on 2/20/18.
//

import Cocoa

extension NSImage.Name {
    static let swiftSource = "Swift Source"
    static let folder = "Folder"
}

class TreeNodeView: NSView {
    
    init(treeNode: TreeNode, dataSource: SourceFileDataSource) {
        super.init(frame: NSRect.zero)
        
        var possibleImage: NSImage?
        switch treeNode.type {
        case .file:
            if treeNode.isSwiftFile {
                possibleImage = Bundle.main.image(forResource: .swiftSource)
            }
        case .group:
            possibleImage = Bundle.main.image(forResource: .folder)
        }
        
        guard let image = possibleImage else {
            assertionFailure("Problem loading image")
            return
        }

        let imageView = NSImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let textField = NSTextField(labelWithString: treeNode.name)
        textField.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(textField)

        let spacer = CGFloat(4)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacer).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

        textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: spacer).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
