//
//  TreeNodeView.swift
//  Mocker
//
//  Created by Greg on 2/20/18.
//

import Cocoa
import XcodeEditor

extension NSImage.Name {
    static let swiftSource = "Swift Source"
    static let folder = "Folder"
}

class TreeNodeView: NSView {
    
    init(treeNode: TreeNode, project: Project) {
        super.init(frame: NSRect.zero)
        
        let possibleImage: NSImage?
        if treeNode.groupMember.groupMemberType() == PBXFileReferenceType,
            let sourceFile = project.file(withKey: treeNode.groupMember.key()),
            sourceFile.type == XcodeSourceFileType.SourceCodeSwift {

            possibleImage = Bundle.main.image(forResource: .swiftSource)
        } else {
            possibleImage = Bundle.main.image(forResource: .folder)
        }
        
        guard let image = possibleImage else {
            assertionFailure("Problem loading image")
            return
        }

        let imageView = NSImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let textField = NSTextField(labelWithString: treeNode.groupMember.displayName() ?? "")
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
