// swiftlint:disable type_name
//
//  String+ExtensionsTests.swift
//  MockerTests
//
//  Created by Greg on 2/28/18.
//

import XCTest
@testable import Mocker

class String_ExtensionsTests: XCTestCase {
    
    // MARK: - firstUppercased -
    
    func testFirstUppercased() {
        var result = ""
        
        result = "".firstUppercased
        XCTAssertEqual(result, "")

        result = "abcd".firstUppercased
        XCTAssertEqual(result, "Abcd")

        result = "ABCD".firstUppercased
        XCTAssertEqual(result, "ABCD")

        result = " abcd".firstUppercased
        XCTAssertEqual(result, " abcd")
    }

    // MARK: - replacedAngleEnclosed -
    
    func testReplacedAngleEnclosed() {
        var result = ""

        result = "this is a string".replacedAngleEnclosed(value: "test", with: "A", and: "B")
        XCTAssertEqual(result, "this is a string")

        result = "this is< a string".replacedAngleEnclosed(value: "is", with: "A", and: "B")
        XCTAssertEqual(result, "this is< a string")

        result = "this is< a s>tring".replacedAngleEnclosed(value: "is", with: "A", and: "B")
        XCTAssertEqual(result, "this A a sBtring")

        result = "this is< a s>tring".replacedAngleEnclosed(value: "is", with: "", and: "?")
        XCTAssertEqual(result, "this  a s?tring")

        result = "this is<is<a>> test".replacedAngleEnclosed(value: "is", with: "C", and: "D")
        XCTAssertEqual(result, "this CCaDD test")

        result = "this is<<is<a>> test".replacedAngleEnclosed(value: "is", with: "C", and: "D")
        XCTAssertEqual(result, "this is<<is<a>> test")

        result = "this is<is<a>> is<test>".replacedAngleEnclosed(value: "is", with: "C", and: "D")
        XCTAssertEqual(result, "this CCaDD CtestD")

        result = "this is<is<a>> is<test>".replacedAngleEnclosed(value: "is", with: "_*", and: "*^")
        XCTAssertEqual(result, "this _*_*a*^*^ _*test*^")

    }

    // MARK: - replacedAngleEnclosedSyntax -
    
    func test_replacedAngleEnclosedSyntax() {
        var result = ""
        
        result = "this is a string".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "this is a string")
        
        result = "protocol<TestProtocol>".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "(TestProtocol)")
        
        result = "Array<TestObject>".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "[TestObject]")
        
        result = "Type<Test>".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "Test.Type")

        result = "Dictionary<String, Any>".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "[String: Any]")
        
        result = "Optional<TestObject>".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "TestObject?")
        
        result = "protocol<UIView, NoteViewInterfaceProtocol>".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "(UIView & NoteViewInterfaceProtocol)")
        
        result = "(view: UIView, interface: NoteViewInterfaceProtocol)".replacedAngleEnclosedSyntax()
        XCTAssertEqual(result, "(view: UIView, interface: NoteViewInterfaceProtocol)")
    }
}

// swiftlint:enable type_name
