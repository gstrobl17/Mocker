//
//  MockXcodeGroupMember.swift
//  MockerTests
//
//  Created by Greg on 2/23/18.
//

import XcodeEditor

class MockXcodeGroupMember: NSObject, XcodeGroupMember {
    
    func key() -> String! {
        nil
    }
    
    func displayName() -> String! {
        nil
    }
    
    func pathRelativeToProjectRoot() -> String! {
        nil
    }
    
    func groupMemberType() -> XcodeMemberType {
        PBXNilType
    }
    
}
