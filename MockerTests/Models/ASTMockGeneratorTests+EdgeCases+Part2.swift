//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+EdgeCases+Part2.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/26/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    // MARK: Very Large (Too Many Methods/Input Parameters) Protocol
    
    var veryLargeProtocol: String {
        """
        protocol VeryLargeProtocol {
        
            var a: String { get }
            var value10: String { get set }
            var value21: String { get set }
            var value32: String { get set }
            var value43: String { get set }
            var x: Double { get set }
            var y: [String]? { get set }
            var z: Bool { get set }

            func foo1(_ value1: Int)
            func foo2(_ value2: Int)
            func foo3(_ value3: Int)
            func foo4(_ value4: Int)
            func foo5(_ value5: Int)
            func foo6(_ value6: Int)
            func foo7(_ value7: Int)
            func foo8(_ value8: Int)
            func foo9(_ value9: Int)
            func foo10(_ value10: Int)
            func foo11(_ value11: Int)
            func foo12(_ value12: Int)
            func foo13(_ value13: Int)
            func foo14(_ value14: Int)
            func foo15(_ value15: Int)
            func foo16(_ value16: Int)
            func foo17(_ value17: Int)
            func foo18(_ value18: Int)
            func foo19(_ value19: Int)
            func foo20(_ value20: Int)
            func foo21(_ value21: Int)
            func foo22(_ value22: Int)
            func foo23(_ value23: Int)
            func foo24(_ value24: Int)
            func foo25(_ value25: Int)
            func foo26(_ value26: Int)
            func foo27(_ value27: Int)
            func foo28(_ value28: Int)
            func foo29(_ value29: Int)
            func foo30(_ value30: Int)
            func foo31(_ value31: Int)
            func foo32(_ value32: Int)
            func foo33(_ value33: Int)
            func foo34(_ value34: Int)
            func foo35(_ value35: Int)
            func foo36(_ value36: Int)
            func foo37(_ value37: Int)
            func foo38(_ value38: Int)
            func foo39(_ value39: Int)
            func foo40(_ value40: Int)
            func foo41(_ value41: Int)
            func foo42(_ value42: Int)
            func foo43(_ value43: Int)
            func foo44(_ value44: Int)
            func foo45(_ value45: Int)
            func foo46(_ value46: Int)
            func foo47(_ value47: Int)
            func foo48(_ value48: Int)
            func foo49(_ value49: Int)
            func foo50(_ value50: Int)
            func foo51(_ value51: Int)
            func foo52(_ value52: Int)
            func foo53(_ value53: Int)
            func foo54(_ value54: Int)
            func foo55(_ value55: Int)
            func foo56(_ value56: Int)
            func foo57(_ value57: Int)
            func foo58(_ value58: Int)
            func foo59(_ value59: Int)
            func foo60(_ value60: Int)
            func foo61(_ value61: Int)
            func foo62(_ value62: Int)
            func foo63(_ value63: Int)
            func foo64(_ value64: Int)
            func foo65(_ value65: Int)
            func foo66(_ value66: Int)
            func foo67(_ value67: Int)
            func foo68(_ value68: Int)
            func foo69(_ value69: Int)
            func foo70(_ value70: Int)
        }
        """
    }
    
    func testCodeGeneration_veryLargeProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: veryLargeProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: VeryLargeProtocol {

                               // MARK: - Variables for Protocol Conformance

                               var a: String
                               var value10: String
                               var value21: String
                               var value32: String
                               var value43: String
                               var x: Double
                               var y: [String]?
                               var z: Bool

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt  // TODO: Increase the size of OptionSet storage. There are more options (70) than bits (64).
                                   static let foo1Value1Called = Method(rawValue: 1 << 0)
                                   static let foo2Value2Called = Method(rawValue: 1 << 1)
                                   static let foo3Value3Called = Method(rawValue: 1 << 2)
                                   static let foo4Value4Called = Method(rawValue: 1 << 3)
                                   static let foo5Value5Called = Method(rawValue: 1 << 4)
                                   static let foo6Value6Called = Method(rawValue: 1 << 5)
                                   static let foo7Value7Called = Method(rawValue: 1 << 6)
                                   static let foo8Value8Called = Method(rawValue: 1 << 7)
                                   static let foo9Value9Called = Method(rawValue: 1 << 8)
                                   static let foo10Value10Called = Method(rawValue: 1 << 9)
                                   static let foo11Value11Called = Method(rawValue: 1 << 10)
                                   static let foo12Value12Called = Method(rawValue: 1 << 11)
                                   static let foo13Value13Called = Method(rawValue: 1 << 12)
                                   static let foo14Value14Called = Method(rawValue: 1 << 13)
                                   static let foo15Value15Called = Method(rawValue: 1 << 14)
                                   static let foo16Value16Called = Method(rawValue: 1 << 15)
                                   static let foo17Value17Called = Method(rawValue: 1 << 16)
                                   static let foo18Value18Called = Method(rawValue: 1 << 17)
                                   static let foo19Value19Called = Method(rawValue: 1 << 18)
                                   static let foo20Value20Called = Method(rawValue: 1 << 19)
                                   static let foo21Value21Called = Method(rawValue: 1 << 20)
                                   static let foo22Value22Called = Method(rawValue: 1 << 21)
                                   static let foo23Value23Called = Method(rawValue: 1 << 22)
                                   static let foo24Value24Called = Method(rawValue: 1 << 23)
                                   static let foo25Value25Called = Method(rawValue: 1 << 24)
                                   static let foo26Value26Called = Method(rawValue: 1 << 25)
                                   static let foo27Value27Called = Method(rawValue: 1 << 26)
                                   static let foo28Value28Called = Method(rawValue: 1 << 27)
                                   static let foo29Value29Called = Method(rawValue: 1 << 28)
                                   static let foo30Value30Called = Method(rawValue: 1 << 29)
                                   static let foo31Value31Called = Method(rawValue: 1 << 30)
                                   static let foo32Value32Called = Method(rawValue: 1 << 31)
                                   static let foo33Value33Called = Method(rawValue: 1 << 32)
                                   static let foo34Value34Called = Method(rawValue: 1 << 33)
                                   static let foo35Value35Called = Method(rawValue: 1 << 34)
                                   static let foo36Value36Called = Method(rawValue: 1 << 35)
                                   static let foo37Value37Called = Method(rawValue: 1 << 36)
                                   static let foo38Value38Called = Method(rawValue: 1 << 37)
                                   static let foo39Value39Called = Method(rawValue: 1 << 38)
                                   static let foo40Value40Called = Method(rawValue: 1 << 39)
                                   static let foo41Value41Called = Method(rawValue: 1 << 40)
                                   static let foo42Value42Called = Method(rawValue: 1 << 41)
                                   static let foo43Value43Called = Method(rawValue: 1 << 42)
                                   static let foo44Value44Called = Method(rawValue: 1 << 43)
                                   static let foo45Value45Called = Method(rawValue: 1 << 44)
                                   static let foo46Value46Called = Method(rawValue: 1 << 45)
                                   static let foo47Value47Called = Method(rawValue: 1 << 46)
                                   static let foo48Value48Called = Method(rawValue: 1 << 47)
                                   static let foo49Value49Called = Method(rawValue: 1 << 48)
                                   static let foo50Value50Called = Method(rawValue: 1 << 49)
                                   static let foo51Value51Called = Method(rawValue: 1 << 50)
                                   static let foo52Value52Called = Method(rawValue: 1 << 51)
                                   static let foo53Value53Called = Method(rawValue: 1 << 52)
                                   static let foo54Value54Called = Method(rawValue: 1 << 53)
                                   static let foo55Value55Called = Method(rawValue: 1 << 54)
                                   static let foo56Value56Called = Method(rawValue: 1 << 55)
                                   static let foo57Value57Called = Method(rawValue: 1 << 56)
                                   static let foo58Value58Called = Method(rawValue: 1 << 57)
                                   static let foo59Value59Called = Method(rawValue: 1 << 58)
                                   static let foo60Value60Called = Method(rawValue: 1 << 59)
                                   static let foo61Value61Called = Method(rawValue: 1 << 60)
                                   static let foo62Value62Called = Method(rawValue: 1 << 61)
                                   static let foo63Value63Called = Method(rawValue: 1 << 62)
                                   static let foo64Value64Called = Method(rawValue: 1 << 63)
                                   static let foo65Value65Called = Method(rawValue: 1 << 64)
                                   static let foo66Value66Called = Method(rawValue: 1 << 65)
                                   static let foo67Value67Called = Method(rawValue: 1 << 66)
                                   static let foo68Value68Called = Method(rawValue: 1 << 67)
                                   static let foo69Value69Called = Method(rawValue: 1 << 68)
                                   static let foo70Value70Called = Method(rawValue: 1 << 69)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt  // TODO: Increase the size of OptionSet storage. There are more options (70) than bits (64).
                                   static let value1 = MethodParameter(rawValue: 1 << 0)
                                   static let value2 = MethodParameter(rawValue: 1 << 1)
                                   static let value3 = MethodParameter(rawValue: 1 << 2)
                                   static let value4 = MethodParameter(rawValue: 1 << 3)
                                   static let value5 = MethodParameter(rawValue: 1 << 4)
                                   static let value6 = MethodParameter(rawValue: 1 << 5)
                                   static let value7 = MethodParameter(rawValue: 1 << 6)
                                   static let value8 = MethodParameter(rawValue: 1 << 7)
                                   static let value9 = MethodParameter(rawValue: 1 << 8)
                                   static let value10Parameter = MethodParameter(rawValue: 1 << 9)
                                   static let value11 = MethodParameter(rawValue: 1 << 10)
                                   static let value12 = MethodParameter(rawValue: 1 << 11)
                                   static let value13 = MethodParameter(rawValue: 1 << 12)
                                   static let value14 = MethodParameter(rawValue: 1 << 13)
                                   static let value15 = MethodParameter(rawValue: 1 << 14)
                                   static let value16 = MethodParameter(rawValue: 1 << 15)
                                   static let value17 = MethodParameter(rawValue: 1 << 16)
                                   static let value18 = MethodParameter(rawValue: 1 << 17)
                                   static let value19 = MethodParameter(rawValue: 1 << 18)
                                   static let value20 = MethodParameter(rawValue: 1 << 19)
                                   static let value21Parameter = MethodParameter(rawValue: 1 << 20)
                                   static let value22 = MethodParameter(rawValue: 1 << 21)
                                   static let value23 = MethodParameter(rawValue: 1 << 22)
                                   static let value24 = MethodParameter(rawValue: 1 << 23)
                                   static let value25 = MethodParameter(rawValue: 1 << 24)
                                   static let value26 = MethodParameter(rawValue: 1 << 25)
                                   static let value27 = MethodParameter(rawValue: 1 << 26)
                                   static let value28 = MethodParameter(rawValue: 1 << 27)
                                   static let value29 = MethodParameter(rawValue: 1 << 28)
                                   static let value30 = MethodParameter(rawValue: 1 << 29)
                                   static let value31 = MethodParameter(rawValue: 1 << 30)
                                   static let value32Parameter = MethodParameter(rawValue: 1 << 31)
                                   static let value33 = MethodParameter(rawValue: 1 << 32)
                                   static let value34 = MethodParameter(rawValue: 1 << 33)
                                   static let value35 = MethodParameter(rawValue: 1 << 34)
                                   static let value36 = MethodParameter(rawValue: 1 << 35)
                                   static let value37 = MethodParameter(rawValue: 1 << 36)
                                   static let value38 = MethodParameter(rawValue: 1 << 37)
                                   static let value39 = MethodParameter(rawValue: 1 << 38)
                                   static let value40 = MethodParameter(rawValue: 1 << 39)
                                   static let value41 = MethodParameter(rawValue: 1 << 40)
                                   static let value42 = MethodParameter(rawValue: 1 << 41)
                                   static let value43Parameter = MethodParameter(rawValue: 1 << 42)
                                   static let value44 = MethodParameter(rawValue: 1 << 43)
                                   static let value45 = MethodParameter(rawValue: 1 << 44)
                                   static let value46 = MethodParameter(rawValue: 1 << 45)
                                   static let value47 = MethodParameter(rawValue: 1 << 46)
                                   static let value48 = MethodParameter(rawValue: 1 << 47)
                                   static let value49 = MethodParameter(rawValue: 1 << 48)
                                   static let value50 = MethodParameter(rawValue: 1 << 49)
                                   static let value51 = MethodParameter(rawValue: 1 << 50)
                                   static let value52 = MethodParameter(rawValue: 1 << 51)
                                   static let value53 = MethodParameter(rawValue: 1 << 52)
                                   static let value54 = MethodParameter(rawValue: 1 << 53)
                                   static let value55 = MethodParameter(rawValue: 1 << 54)
                                   static let value56 = MethodParameter(rawValue: 1 << 55)
                                   static let value57 = MethodParameter(rawValue: 1 << 56)
                                   static let value58 = MethodParameter(rawValue: 1 << 57)
                                   static let value59 = MethodParameter(rawValue: 1 << 58)
                                   static let value60 = MethodParameter(rawValue: 1 << 59)
                                   static let value61 = MethodParameter(rawValue: 1 << 60)
                                   static let value62 = MethodParameter(rawValue: 1 << 61)
                                   static let value63 = MethodParameter(rawValue: 1 << 62)
                                   static let value64 = MethodParameter(rawValue: 1 << 63)
                                   static let value65 = MethodParameter(rawValue: 1 << 64)
                                   static let value66 = MethodParameter(rawValue: 1 << 65)
                                   static let value67 = MethodParameter(rawValue: 1 << 66)
                                   static let value68 = MethodParameter(rawValue: 1 << 67)
                                   static let value69 = MethodParameter(rawValue: 1 << 68)
                                   static let value70 = MethodParameter(rawValue: 1 << 69)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var value1: Int?
                               private(set) var value2: Int?
                               private(set) var value3: Int?
                               private(set) var value4: Int?
                               private(set) var value5: Int?
                               private(set) var value6: Int?
                               private(set) var value7: Int?
                               private(set) var value8: Int?
                               private(set) var value9: Int?
                               private(set) var value10Parameter: Int?
                               private(set) var value11: Int?
                               private(set) var value12: Int?
                               private(set) var value13: Int?
                               private(set) var value14: Int?
                               private(set) var value15: Int?
                               private(set) var value16: Int?
                               private(set) var value17: Int?
                               private(set) var value18: Int?
                               private(set) var value19: Int?
                               private(set) var value20: Int?
                               private(set) var value21Parameter: Int?
                               private(set) var value22: Int?
                               private(set) var value23: Int?
                               private(set) var value24: Int?
                               private(set) var value25: Int?
                               private(set) var value26: Int?
                               private(set) var value27: Int?
                               private(set) var value28: Int?
                               private(set) var value29: Int?
                               private(set) var value30: Int?
                               private(set) var value31: Int?
                               private(set) var value32Parameter: Int?
                               private(set) var value33: Int?
                               private(set) var value34: Int?
                               private(set) var value35: Int?
                               private(set) var value36: Int?
                               private(set) var value37: Int?
                               private(set) var value38: Int?
                               private(set) var value39: Int?
                               private(set) var value40: Int?
                               private(set) var value41: Int?
                               private(set) var value42: Int?
                               private(set) var value43Parameter: Int?
                               private(set) var value44: Int?
                               private(set) var value45: Int?
                               private(set) var value46: Int?
                               private(set) var value47: Int?
                               private(set) var value48: Int?
                               private(set) var value49: Int?
                               private(set) var value50: Int?
                               private(set) var value51: Int?
                               private(set) var value52: Int?
                               private(set) var value53: Int?
                               private(set) var value54: Int?
                               private(set) var value55: Int?
                               private(set) var value56: Int?
                               private(set) var value57: Int?
                               private(set) var value58: Int?
                               private(set) var value59: Int?
                               private(set) var value60: Int?
                               private(set) var value61: Int?
                               private(set) var value62: Int?
                               private(set) var value63: Int?
                               private(set) var value64: Int?
                               private(set) var value65: Int?
                               private(set) var value66: Int?
                               private(set) var value67: Int?
                               private(set) var value68: Int?
                               private(set) var value69: Int?
                               private(set) var value70: Int?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   value1 = nil
                                   value2 = nil
                                   value3 = nil
                                   value4 = nil
                                   value5 = nil
                                   value6 = nil
                                   value7 = nil
                                   value8 = nil
                                   value9 = nil
                                   value10Parameter = nil
                                   value11 = nil
                                   value12 = nil
                                   value13 = nil
                                   value14 = nil
                                   value15 = nil
                                   value16 = nil
                                   value17 = nil
                                   value18 = nil
                                   value19 = nil
                                   value20 = nil
                                   value21Parameter = nil
                                   value22 = nil
                                   value23 = nil
                                   value24 = nil
                                   value25 = nil
                                   value26 = nil
                                   value27 = nil
                                   value28 = nil
                                   value29 = nil
                                   value30 = nil
                                   value31 = nil
                                   value32Parameter = nil
                                   value33 = nil
                                   value34 = nil
                                   value35 = nil
                                   value36 = nil
                                   value37 = nil
                                   value38 = nil
                                   value39 = nil
                                   value40 = nil
                                   value41 = nil
                                   value42 = nil
                                   value43Parameter = nil
                                   value44 = nil
                                   value45 = nil
                                   value46 = nil
                                   value47 = nil
                                   value48 = nil
                                   value49 = nil
                                   value50 = nil
                                   value51 = nil
                                   value52 = nil
                                   value53 = nil
                                   value54 = nil
                                   value55 = nil
                                   value56 = nil
                                   value57 = nil
                                   value58 = nil
                                   value59 = nil
                                   value60 = nil
                                   value61 = nil
                                   value62 = nil
                                   value63 = nil
                                   value64 = nil
                                   value65 = nil
                                   value66 = nil
                                   value67 = nil
                                   value68 = nil
                                   value69 = nil
                                   value70 = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(_ value1: Int) {
                                   calledMethods.insert(.foo1Value1Called)
                                   self.value1 = value1
                                   assignedParameters.insert(.value1)
                               }

                               func foo2(_ value2: Int) {
                                   calledMethods.insert(.foo2Value2Called)
                                   self.value2 = value2
                                   assignedParameters.insert(.value2)
                               }

                               func foo3(_ value3: Int) {
                                   calledMethods.insert(.foo3Value3Called)
                                   self.value3 = value3
                                   assignedParameters.insert(.value3)
                               }

                               func foo4(_ value4: Int) {
                                   calledMethods.insert(.foo4Value4Called)
                                   self.value4 = value4
                                   assignedParameters.insert(.value4)
                               }

                               func foo5(_ value5: Int) {
                                   calledMethods.insert(.foo5Value5Called)
                                   self.value5 = value5
                                   assignedParameters.insert(.value5)
                               }

                               func foo6(_ value6: Int) {
                                   calledMethods.insert(.foo6Value6Called)
                                   self.value6 = value6
                                   assignedParameters.insert(.value6)
                               }

                               func foo7(_ value7: Int) {
                                   calledMethods.insert(.foo7Value7Called)
                                   self.value7 = value7
                                   assignedParameters.insert(.value7)
                               }

                               func foo8(_ value8: Int) {
                                   calledMethods.insert(.foo8Value8Called)
                                   self.value8 = value8
                                   assignedParameters.insert(.value8)
                               }

                               func foo9(_ value9: Int) {
                                   calledMethods.insert(.foo9Value9Called)
                                   self.value9 = value9
                                   assignedParameters.insert(.value9)
                               }

                               func foo10(_ value10: Int) {
                                   calledMethods.insert(.foo10Value10Called)
                                   self.value10Parameter = value10
                                   assignedParameters.insert(.value10Parameter)
                               }

                               func foo11(_ value11: Int) {
                                   calledMethods.insert(.foo11Value11Called)
                                   self.value11 = value11
                                   assignedParameters.insert(.value11)
                               }

                               func foo12(_ value12: Int) {
                                   calledMethods.insert(.foo12Value12Called)
                                   self.value12 = value12
                                   assignedParameters.insert(.value12)
                               }

                               func foo13(_ value13: Int) {
                                   calledMethods.insert(.foo13Value13Called)
                                   self.value13 = value13
                                   assignedParameters.insert(.value13)
                               }

                               func foo14(_ value14: Int) {
                                   calledMethods.insert(.foo14Value14Called)
                                   self.value14 = value14
                                   assignedParameters.insert(.value14)
                               }

                               func foo15(_ value15: Int) {
                                   calledMethods.insert(.foo15Value15Called)
                                   self.value15 = value15
                                   assignedParameters.insert(.value15)
                               }

                               func foo16(_ value16: Int) {
                                   calledMethods.insert(.foo16Value16Called)
                                   self.value16 = value16
                                   assignedParameters.insert(.value16)
                               }

                               func foo17(_ value17: Int) {
                                   calledMethods.insert(.foo17Value17Called)
                                   self.value17 = value17
                                   assignedParameters.insert(.value17)
                               }

                               func foo18(_ value18: Int) {
                                   calledMethods.insert(.foo18Value18Called)
                                   self.value18 = value18
                                   assignedParameters.insert(.value18)
                               }

                               func foo19(_ value19: Int) {
                                   calledMethods.insert(.foo19Value19Called)
                                   self.value19 = value19
                                   assignedParameters.insert(.value19)
                               }

                               func foo20(_ value20: Int) {
                                   calledMethods.insert(.foo20Value20Called)
                                   self.value20 = value20
                                   assignedParameters.insert(.value20)
                               }

                               func foo21(_ value21: Int) {
                                   calledMethods.insert(.foo21Value21Called)
                                   self.value21Parameter = value21
                                   assignedParameters.insert(.value21Parameter)
                               }

                               func foo22(_ value22: Int) {
                                   calledMethods.insert(.foo22Value22Called)
                                   self.value22 = value22
                                   assignedParameters.insert(.value22)
                               }

                               func foo23(_ value23: Int) {
                                   calledMethods.insert(.foo23Value23Called)
                                   self.value23 = value23
                                   assignedParameters.insert(.value23)
                               }

                               func foo24(_ value24: Int) {
                                   calledMethods.insert(.foo24Value24Called)
                                   self.value24 = value24
                                   assignedParameters.insert(.value24)
                               }

                               func foo25(_ value25: Int) {
                                   calledMethods.insert(.foo25Value25Called)
                                   self.value25 = value25
                                   assignedParameters.insert(.value25)
                               }

                               func foo26(_ value26: Int) {
                                   calledMethods.insert(.foo26Value26Called)
                                   self.value26 = value26
                                   assignedParameters.insert(.value26)
                               }

                               func foo27(_ value27: Int) {
                                   calledMethods.insert(.foo27Value27Called)
                                   self.value27 = value27
                                   assignedParameters.insert(.value27)
                               }

                               func foo28(_ value28: Int) {
                                   calledMethods.insert(.foo28Value28Called)
                                   self.value28 = value28
                                   assignedParameters.insert(.value28)
                               }

                               func foo29(_ value29: Int) {
                                   calledMethods.insert(.foo29Value29Called)
                                   self.value29 = value29
                                   assignedParameters.insert(.value29)
                               }

                               func foo30(_ value30: Int) {
                                   calledMethods.insert(.foo30Value30Called)
                                   self.value30 = value30
                                   assignedParameters.insert(.value30)
                               }

                               func foo31(_ value31: Int) {
                                   calledMethods.insert(.foo31Value31Called)
                                   self.value31 = value31
                                   assignedParameters.insert(.value31)
                               }

                               func foo32(_ value32: Int) {
                                   calledMethods.insert(.foo32Value32Called)
                                   self.value32Parameter = value32
                                   assignedParameters.insert(.value32Parameter)
                               }

                               func foo33(_ value33: Int) {
                                   calledMethods.insert(.foo33Value33Called)
                                   self.value33 = value33
                                   assignedParameters.insert(.value33)
                               }

                               func foo34(_ value34: Int) {
                                   calledMethods.insert(.foo34Value34Called)
                                   self.value34 = value34
                                   assignedParameters.insert(.value34)
                               }

                               func foo35(_ value35: Int) {
                                   calledMethods.insert(.foo35Value35Called)
                                   self.value35 = value35
                                   assignedParameters.insert(.value35)
                               }

                               func foo36(_ value36: Int) {
                                   calledMethods.insert(.foo36Value36Called)
                                   self.value36 = value36
                                   assignedParameters.insert(.value36)
                               }

                               func foo37(_ value37: Int) {
                                   calledMethods.insert(.foo37Value37Called)
                                   self.value37 = value37
                                   assignedParameters.insert(.value37)
                               }

                               func foo38(_ value38: Int) {
                                   calledMethods.insert(.foo38Value38Called)
                                   self.value38 = value38
                                   assignedParameters.insert(.value38)
                               }

                               func foo39(_ value39: Int) {
                                   calledMethods.insert(.foo39Value39Called)
                                   self.value39 = value39
                                   assignedParameters.insert(.value39)
                               }

                               func foo40(_ value40: Int) {
                                   calledMethods.insert(.foo40Value40Called)
                                   self.value40 = value40
                                   assignedParameters.insert(.value40)
                               }

                               func foo41(_ value41: Int) {
                                   calledMethods.insert(.foo41Value41Called)
                                   self.value41 = value41
                                   assignedParameters.insert(.value41)
                               }

                               func foo42(_ value42: Int) {
                                   calledMethods.insert(.foo42Value42Called)
                                   self.value42 = value42
                                   assignedParameters.insert(.value42)
                               }

                               func foo43(_ value43: Int) {
                                   calledMethods.insert(.foo43Value43Called)
                                   self.value43Parameter = value43
                                   assignedParameters.insert(.value43Parameter)
                               }

                               func foo44(_ value44: Int) {
                                   calledMethods.insert(.foo44Value44Called)
                                   self.value44 = value44
                                   assignedParameters.insert(.value44)
                               }

                               func foo45(_ value45: Int) {
                                   calledMethods.insert(.foo45Value45Called)
                                   self.value45 = value45
                                   assignedParameters.insert(.value45)
                               }

                               func foo46(_ value46: Int) {
                                   calledMethods.insert(.foo46Value46Called)
                                   self.value46 = value46
                                   assignedParameters.insert(.value46)
                               }

                               func foo47(_ value47: Int) {
                                   calledMethods.insert(.foo47Value47Called)
                                   self.value47 = value47
                                   assignedParameters.insert(.value47)
                               }

                               func foo48(_ value48: Int) {
                                   calledMethods.insert(.foo48Value48Called)
                                   self.value48 = value48
                                   assignedParameters.insert(.value48)
                               }

                               func foo49(_ value49: Int) {
                                   calledMethods.insert(.foo49Value49Called)
                                   self.value49 = value49
                                   assignedParameters.insert(.value49)
                               }

                               func foo50(_ value50: Int) {
                                   calledMethods.insert(.foo50Value50Called)
                                   self.value50 = value50
                                   assignedParameters.insert(.value50)
                               }

                               func foo51(_ value51: Int) {
                                   calledMethods.insert(.foo51Value51Called)
                                   self.value51 = value51
                                   assignedParameters.insert(.value51)
                               }

                               func foo52(_ value52: Int) {
                                   calledMethods.insert(.foo52Value52Called)
                                   self.value52 = value52
                                   assignedParameters.insert(.value52)
                               }

                               func foo53(_ value53: Int) {
                                   calledMethods.insert(.foo53Value53Called)
                                   self.value53 = value53
                                   assignedParameters.insert(.value53)
                               }

                               func foo54(_ value54: Int) {
                                   calledMethods.insert(.foo54Value54Called)
                                   self.value54 = value54
                                   assignedParameters.insert(.value54)
                               }

                               func foo55(_ value55: Int) {
                                   calledMethods.insert(.foo55Value55Called)
                                   self.value55 = value55
                                   assignedParameters.insert(.value55)
                               }

                               func foo56(_ value56: Int) {
                                   calledMethods.insert(.foo56Value56Called)
                                   self.value56 = value56
                                   assignedParameters.insert(.value56)
                               }

                               func foo57(_ value57: Int) {
                                   calledMethods.insert(.foo57Value57Called)
                                   self.value57 = value57
                                   assignedParameters.insert(.value57)
                               }

                               func foo58(_ value58: Int) {
                                   calledMethods.insert(.foo58Value58Called)
                                   self.value58 = value58
                                   assignedParameters.insert(.value58)
                               }

                               func foo59(_ value59: Int) {
                                   calledMethods.insert(.foo59Value59Called)
                                   self.value59 = value59
                                   assignedParameters.insert(.value59)
                               }

                               func foo60(_ value60: Int) {
                                   calledMethods.insert(.foo60Value60Called)
                                   self.value60 = value60
                                   assignedParameters.insert(.value60)
                               }

                               func foo61(_ value61: Int) {
                                   calledMethods.insert(.foo61Value61Called)
                                   self.value61 = value61
                                   assignedParameters.insert(.value61)
                               }

                               func foo62(_ value62: Int) {
                                   calledMethods.insert(.foo62Value62Called)
                                   self.value62 = value62
                                   assignedParameters.insert(.value62)
                               }

                               func foo63(_ value63: Int) {
                                   calledMethods.insert(.foo63Value63Called)
                                   self.value63 = value63
                                   assignedParameters.insert(.value63)
                               }

                               func foo64(_ value64: Int) {
                                   calledMethods.insert(.foo64Value64Called)
                                   self.value64 = value64
                                   assignedParameters.insert(.value64)
                               }

                               func foo65(_ value65: Int) {
                                   calledMethods.insert(.foo65Value65Called)
                                   self.value65 = value65
                                   assignedParameters.insert(.value65)
                               }

                               func foo66(_ value66: Int) {
                                   calledMethods.insert(.foo66Value66Called)
                                   self.value66 = value66
                                   assignedParameters.insert(.value66)
                               }

                               func foo67(_ value67: Int) {
                                   calledMethods.insert(.foo67Value67Called)
                                   self.value67 = value67
                                   assignedParameters.insert(.value67)
                               }

                               func foo68(_ value68: Int) {
                                   calledMethods.insert(.foo68Value68Called)
                                   self.value68 = value68
                                   assignedParameters.insert(.value68)
                               }

                               func foo69(_ value69: Int) {
                                   calledMethods.insert(.foo69Value69Called)
                                   self.value69 = value69
                                   assignedParameters.insert(.value69)
                               }

                               func foo70(_ value70: Int) {
                                   calledMethods.insert(.foo70Value70Called)
                                   self.value70 = value70
                                   assignedParameters.insert(.value70)
                               }

                           }

                           extension MockTest.Method: CustomStringConvertible {
                               var description: String {
                                   var value = "["
                                   var first = true
                                   func handleFirst() {
                                       if first {
                                           first = false
                                       } else {
                                           value += ", "
                                       }
                                   }

                                   if self.contains(.foo1Value1Called) {
                                       handleFirst()
                                       value += ".foo1Value1Called"
                                   }
                                   if self.contains(.foo2Value2Called) {
                                       handleFirst()
                                       value += ".foo2Value2Called"
                                   }
                                   if self.contains(.foo3Value3Called) {
                                       handleFirst()
                                       value += ".foo3Value3Called"
                                   }
                                   if self.contains(.foo4Value4Called) {
                                       handleFirst()
                                       value += ".foo4Value4Called"
                                   }
                                   if self.contains(.foo5Value5Called) {
                                       handleFirst()
                                       value += ".foo5Value5Called"
                                   }
                                   if self.contains(.foo6Value6Called) {
                                       handleFirst()
                                       value += ".foo6Value6Called"
                                   }
                                   if self.contains(.foo7Value7Called) {
                                       handleFirst()
                                       value += ".foo7Value7Called"
                                   }
                                   if self.contains(.foo8Value8Called) {
                                       handleFirst()
                                       value += ".foo8Value8Called"
                                   }
                                   if self.contains(.foo9Value9Called) {
                                       handleFirst()
                                       value += ".foo9Value9Called"
                                   }
                                   if self.contains(.foo10Value10Called) {
                                       handleFirst()
                                       value += ".foo10Value10Called"
                                   }
                                   if self.contains(.foo11Value11Called) {
                                       handleFirst()
                                       value += ".foo11Value11Called"
                                   }
                                   if self.contains(.foo12Value12Called) {
                                       handleFirst()
                                       value += ".foo12Value12Called"
                                   }
                                   if self.contains(.foo13Value13Called) {
                                       handleFirst()
                                       value += ".foo13Value13Called"
                                   }
                                   if self.contains(.foo14Value14Called) {
                                       handleFirst()
                                       value += ".foo14Value14Called"
                                   }
                                   if self.contains(.foo15Value15Called) {
                                       handleFirst()
                                       value += ".foo15Value15Called"
                                   }
                                   if self.contains(.foo16Value16Called) {
                                       handleFirst()
                                       value += ".foo16Value16Called"
                                   }
                                   if self.contains(.foo17Value17Called) {
                                       handleFirst()
                                       value += ".foo17Value17Called"
                                   }
                                   if self.contains(.foo18Value18Called) {
                                       handleFirst()
                                       value += ".foo18Value18Called"
                                   }
                                   if self.contains(.foo19Value19Called) {
                                       handleFirst()
                                       value += ".foo19Value19Called"
                                   }
                                   if self.contains(.foo20Value20Called) {
                                       handleFirst()
                                       value += ".foo20Value20Called"
                                   }
                                   if self.contains(.foo21Value21Called) {
                                       handleFirst()
                                       value += ".foo21Value21Called"
                                   }
                                   if self.contains(.foo22Value22Called) {
                                       handleFirst()
                                       value += ".foo22Value22Called"
                                   }
                                   if self.contains(.foo23Value23Called) {
                                       handleFirst()
                                       value += ".foo23Value23Called"
                                   }
                                   if self.contains(.foo24Value24Called) {
                                       handleFirst()
                                       value += ".foo24Value24Called"
                                   }
                                   if self.contains(.foo25Value25Called) {
                                       handleFirst()
                                       value += ".foo25Value25Called"
                                   }
                                   if self.contains(.foo26Value26Called) {
                                       handleFirst()
                                       value += ".foo26Value26Called"
                                   }
                                   if self.contains(.foo27Value27Called) {
                                       handleFirst()
                                       value += ".foo27Value27Called"
                                   }
                                   if self.contains(.foo28Value28Called) {
                                       handleFirst()
                                       value += ".foo28Value28Called"
                                   }
                                   if self.contains(.foo29Value29Called) {
                                       handleFirst()
                                       value += ".foo29Value29Called"
                                   }
                                   if self.contains(.foo30Value30Called) {
                                       handleFirst()
                                       value += ".foo30Value30Called"
                                   }
                                   if self.contains(.foo31Value31Called) {
                                       handleFirst()
                                       value += ".foo31Value31Called"
                                   }
                                   if self.contains(.foo32Value32Called) {
                                       handleFirst()
                                       value += ".foo32Value32Called"
                                   }
                                   if self.contains(.foo33Value33Called) {
                                       handleFirst()
                                       value += ".foo33Value33Called"
                                   }
                                   if self.contains(.foo34Value34Called) {
                                       handleFirst()
                                       value += ".foo34Value34Called"
                                   }
                                   if self.contains(.foo35Value35Called) {
                                       handleFirst()
                                       value += ".foo35Value35Called"
                                   }
                                   if self.contains(.foo36Value36Called) {
                                       handleFirst()
                                       value += ".foo36Value36Called"
                                   }
                                   if self.contains(.foo37Value37Called) {
                                       handleFirst()
                                       value += ".foo37Value37Called"
                                   }
                                   if self.contains(.foo38Value38Called) {
                                       handleFirst()
                                       value += ".foo38Value38Called"
                                   }
                                   if self.contains(.foo39Value39Called) {
                                       handleFirst()
                                       value += ".foo39Value39Called"
                                   }
                                   if self.contains(.foo40Value40Called) {
                                       handleFirst()
                                       value += ".foo40Value40Called"
                                   }
                                   if self.contains(.foo41Value41Called) {
                                       handleFirst()
                                       value += ".foo41Value41Called"
                                   }
                                   if self.contains(.foo42Value42Called) {
                                       handleFirst()
                                       value += ".foo42Value42Called"
                                   }
                                   if self.contains(.foo43Value43Called) {
                                       handleFirst()
                                       value += ".foo43Value43Called"
                                   }
                                   if self.contains(.foo44Value44Called) {
                                       handleFirst()
                                       value += ".foo44Value44Called"
                                   }
                                   if self.contains(.foo45Value45Called) {
                                       handleFirst()
                                       value += ".foo45Value45Called"
                                   }
                                   if self.contains(.foo46Value46Called) {
                                       handleFirst()
                                       value += ".foo46Value46Called"
                                   }
                                   if self.contains(.foo47Value47Called) {
                                       handleFirst()
                                       value += ".foo47Value47Called"
                                   }
                                   if self.contains(.foo48Value48Called) {
                                       handleFirst()
                                       value += ".foo48Value48Called"
                                   }
                                   if self.contains(.foo49Value49Called) {
                                       handleFirst()
                                       value += ".foo49Value49Called"
                                   }
                                   if self.contains(.foo50Value50Called) {
                                       handleFirst()
                                       value += ".foo50Value50Called"
                                   }
                                   if self.contains(.foo51Value51Called) {
                                       handleFirst()
                                       value += ".foo51Value51Called"
                                   }
                                   if self.contains(.foo52Value52Called) {
                                       handleFirst()
                                       value += ".foo52Value52Called"
                                   }
                                   if self.contains(.foo53Value53Called) {
                                       handleFirst()
                                       value += ".foo53Value53Called"
                                   }
                                   if self.contains(.foo54Value54Called) {
                                       handleFirst()
                                       value += ".foo54Value54Called"
                                   }
                                   if self.contains(.foo55Value55Called) {
                                       handleFirst()
                                       value += ".foo55Value55Called"
                                   }
                                   if self.contains(.foo56Value56Called) {
                                       handleFirst()
                                       value += ".foo56Value56Called"
                                   }
                                   if self.contains(.foo57Value57Called) {
                                       handleFirst()
                                       value += ".foo57Value57Called"
                                   }
                                   if self.contains(.foo58Value58Called) {
                                       handleFirst()
                                       value += ".foo58Value58Called"
                                   }
                                   if self.contains(.foo59Value59Called) {
                                       handleFirst()
                                       value += ".foo59Value59Called"
                                   }
                                   if self.contains(.foo60Value60Called) {
                                       handleFirst()
                                       value += ".foo60Value60Called"
                                   }
                                   if self.contains(.foo61Value61Called) {
                                       handleFirst()
                                       value += ".foo61Value61Called"
                                   }
                                   if self.contains(.foo62Value62Called) {
                                       handleFirst()
                                       value += ".foo62Value62Called"
                                   }
                                   if self.contains(.foo63Value63Called) {
                                       handleFirst()
                                       value += ".foo63Value63Called"
                                   }
                                   if self.contains(.foo64Value64Called) {
                                       handleFirst()
                                       value += ".foo64Value64Called"
                                   }
                                   if self.contains(.foo65Value65Called) {
                                       handleFirst()
                                       value += ".foo65Value65Called"
                                   }
                                   if self.contains(.foo66Value66Called) {
                                       handleFirst()
                                       value += ".foo66Value66Called"
                                   }
                                   if self.contains(.foo67Value67Called) {
                                       handleFirst()
                                       value += ".foo67Value67Called"
                                   }
                                   if self.contains(.foo68Value68Called) {
                                       handleFirst()
                                       value += ".foo68Value68Called"
                                   }
                                   if self.contains(.foo69Value69Called) {
                                       handleFirst()
                                       value += ".foo69Value69Called"
                                   }
                                   if self.contains(.foo70Value70Called) {
                                       handleFirst()
                                       value += ".foo70Value70Called"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest.MethodParameter: CustomStringConvertible {
                               var description: String {
                                   var value = "["
                                   var first = true
                                   func handleFirst() {
                                       if first {
                                           first = false
                                       } else {
                                           value += ", "
                                       }
                                   }

                                   if self.contains(.value1) {
                                       handleFirst()
                                       value += ".value1"
                                   }
                                   if self.contains(.value2) {
                                       handleFirst()
                                       value += ".value2"
                                   }
                                   if self.contains(.value3) {
                                       handleFirst()
                                       value += ".value3"
                                   }
                                   if self.contains(.value4) {
                                       handleFirst()
                                       value += ".value4"
                                   }
                                   if self.contains(.value5) {
                                       handleFirst()
                                       value += ".value5"
                                   }
                                   if self.contains(.value6) {
                                       handleFirst()
                                       value += ".value6"
                                   }
                                   if self.contains(.value7) {
                                       handleFirst()
                                       value += ".value7"
                                   }
                                   if self.contains(.value8) {
                                       handleFirst()
                                       value += ".value8"
                                   }
                                   if self.contains(.value9) {
                                       handleFirst()
                                       value += ".value9"
                                   }
                                   if self.contains(.value10Parameter) {
                                       handleFirst()
                                       value += ".value10Parameter"
                                   }
                                   if self.contains(.value11) {
                                       handleFirst()
                                       value += ".value11"
                                   }
                                   if self.contains(.value12) {
                                       handleFirst()
                                       value += ".value12"
                                   }
                                   if self.contains(.value13) {
                                       handleFirst()
                                       value += ".value13"
                                   }
                                   if self.contains(.value14) {
                                       handleFirst()
                                       value += ".value14"
                                   }
                                   if self.contains(.value15) {
                                       handleFirst()
                                       value += ".value15"
                                   }
                                   if self.contains(.value16) {
                                       handleFirst()
                                       value += ".value16"
                                   }
                                   if self.contains(.value17) {
                                       handleFirst()
                                       value += ".value17"
                                   }
                                   if self.contains(.value18) {
                                       handleFirst()
                                       value += ".value18"
                                   }
                                   if self.contains(.value19) {
                                       handleFirst()
                                       value += ".value19"
                                   }
                                   if self.contains(.value20) {
                                       handleFirst()
                                       value += ".value20"
                                   }
                                   if self.contains(.value21Parameter) {
                                       handleFirst()
                                       value += ".value21Parameter"
                                   }
                                   if self.contains(.value22) {
                                       handleFirst()
                                       value += ".value22"
                                   }
                                   if self.contains(.value23) {
                                       handleFirst()
                                       value += ".value23"
                                   }
                                   if self.contains(.value24) {
                                       handleFirst()
                                       value += ".value24"
                                   }
                                   if self.contains(.value25) {
                                       handleFirst()
                                       value += ".value25"
                                   }
                                   if self.contains(.value26) {
                                       handleFirst()
                                       value += ".value26"
                                   }
                                   if self.contains(.value27) {
                                       handleFirst()
                                       value += ".value27"
                                   }
                                   if self.contains(.value28) {
                                       handleFirst()
                                       value += ".value28"
                                   }
                                   if self.contains(.value29) {
                                       handleFirst()
                                       value += ".value29"
                                   }
                                   if self.contains(.value30) {
                                       handleFirst()
                                       value += ".value30"
                                   }
                                   if self.contains(.value31) {
                                       handleFirst()
                                       value += ".value31"
                                   }
                                   if self.contains(.value32Parameter) {
                                       handleFirst()
                                       value += ".value32Parameter"
                                   }
                                   if self.contains(.value33) {
                                       handleFirst()
                                       value += ".value33"
                                   }
                                   if self.contains(.value34) {
                                       handleFirst()
                                       value += ".value34"
                                   }
                                   if self.contains(.value35) {
                                       handleFirst()
                                       value += ".value35"
                                   }
                                   if self.contains(.value36) {
                                       handleFirst()
                                       value += ".value36"
                                   }
                                   if self.contains(.value37) {
                                       handleFirst()
                                       value += ".value37"
                                   }
                                   if self.contains(.value38) {
                                       handleFirst()
                                       value += ".value38"
                                   }
                                   if self.contains(.value39) {
                                       handleFirst()
                                       value += ".value39"
                                   }
                                   if self.contains(.value40) {
                                       handleFirst()
                                       value += ".value40"
                                   }
                                   if self.contains(.value41) {
                                       handleFirst()
                                       value += ".value41"
                                   }
                                   if self.contains(.value42) {
                                       handleFirst()
                                       value += ".value42"
                                   }
                                   if self.contains(.value43Parameter) {
                                       handleFirst()
                                       value += ".value43Parameter"
                                   }
                                   if self.contains(.value44) {
                                       handleFirst()
                                       value += ".value44"
                                   }
                                   if self.contains(.value45) {
                                       handleFirst()
                                       value += ".value45"
                                   }
                                   if self.contains(.value46) {
                                       handleFirst()
                                       value += ".value46"
                                   }
                                   if self.contains(.value47) {
                                       handleFirst()
                                       value += ".value47"
                                   }
                                   if self.contains(.value48) {
                                       handleFirst()
                                       value += ".value48"
                                   }
                                   if self.contains(.value49) {
                                       handleFirst()
                                       value += ".value49"
                                   }
                                   if self.contains(.value50) {
                                       handleFirst()
                                       value += ".value50"
                                   }
                                   if self.contains(.value51) {
                                       handleFirst()
                                       value += ".value51"
                                   }
                                   if self.contains(.value52) {
                                       handleFirst()
                                       value += ".value52"
                                   }
                                   if self.contains(.value53) {
                                       handleFirst()
                                       value += ".value53"
                                   }
                                   if self.contains(.value54) {
                                       handleFirst()
                                       value += ".value54"
                                   }
                                   if self.contains(.value55) {
                                       handleFirst()
                                       value += ".value55"
                                   }
                                   if self.contains(.value56) {
                                       handleFirst()
                                       value += ".value56"
                                   }
                                   if self.contains(.value57) {
                                       handleFirst()
                                       value += ".value57"
                                   }
                                   if self.contains(.value58) {
                                       handleFirst()
                                       value += ".value58"
                                   }
                                   if self.contains(.value59) {
                                       handleFirst()
                                       value += ".value59"
                                   }
                                   if self.contains(.value60) {
                                       handleFirst()
                                       value += ".value60"
                                   }
                                   if self.contains(.value61) {
                                       handleFirst()
                                       value += ".value61"
                                   }
                                   if self.contains(.value62) {
                                       handleFirst()
                                       value += ".value62"
                                   }
                                   if self.contains(.value63) {
                                       handleFirst()
                                       value += ".value63"
                                   }
                                   if self.contains(.value64) {
                                       handleFirst()
                                       value += ".value64"
                                   }
                                   if self.contains(.value65) {
                                       handleFirst()
                                       value += ".value65"
                                   }
                                   if self.contains(.value66) {
                                       handleFirst()
                                       value += ".value66"
                                   }
                                   if self.contains(.value67) {
                                       handleFirst()
                                       value += ".value67"
                                   }
                                   if self.contains(.value68) {
                                       handleFirst()
                                       value += ".value68"
                                   }
                                   if self.contains(.value69) {
                                       handleFirst()
                                       value += ".value69"
                                   }
                                   if self.contains(.value70) {
                                       handleFirst()
                                       value += ".value70"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethodsAndAssignedParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        //printFirstDifference(code, expectedCode)  //Uncomment if needed. Too slow for regular execution
    }
    
    func testCodeGeneration_veryLargeProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: veryLargeProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: VeryLargeProtocol {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var a: String
                               public var value10: String
                               public var value21: String
                               public var value32: String
                               public var value43: String
                               public var x: Double
                               public var y: [String]?
                               public var z: Bool

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt  // TODO: Increase the size of OptionSet storage. There are more options (70) than bits (64).
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo1Value1Called = Method(rawValue: 1 << 0)
                                   public static let foo2Value2Called = Method(rawValue: 1 << 1)
                                   public static let foo3Value3Called = Method(rawValue: 1 << 2)
                                   public static let foo4Value4Called = Method(rawValue: 1 << 3)
                                   public static let foo5Value5Called = Method(rawValue: 1 << 4)
                                   public static let foo6Value6Called = Method(rawValue: 1 << 5)
                                   public static let foo7Value7Called = Method(rawValue: 1 << 6)
                                   public static let foo8Value8Called = Method(rawValue: 1 << 7)
                                   public static let foo9Value9Called = Method(rawValue: 1 << 8)
                                   public static let foo10Value10Called = Method(rawValue: 1 << 9)
                                   public static let foo11Value11Called = Method(rawValue: 1 << 10)
                                   public static let foo12Value12Called = Method(rawValue: 1 << 11)
                                   public static let foo13Value13Called = Method(rawValue: 1 << 12)
                                   public static let foo14Value14Called = Method(rawValue: 1 << 13)
                                   public static let foo15Value15Called = Method(rawValue: 1 << 14)
                                   public static let foo16Value16Called = Method(rawValue: 1 << 15)
                                   public static let foo17Value17Called = Method(rawValue: 1 << 16)
                                   public static let foo18Value18Called = Method(rawValue: 1 << 17)
                                   public static let foo19Value19Called = Method(rawValue: 1 << 18)
                                   public static let foo20Value20Called = Method(rawValue: 1 << 19)
                                   public static let foo21Value21Called = Method(rawValue: 1 << 20)
                                   public static let foo22Value22Called = Method(rawValue: 1 << 21)
                                   public static let foo23Value23Called = Method(rawValue: 1 << 22)
                                   public static let foo24Value24Called = Method(rawValue: 1 << 23)
                                   public static let foo25Value25Called = Method(rawValue: 1 << 24)
                                   public static let foo26Value26Called = Method(rawValue: 1 << 25)
                                   public static let foo27Value27Called = Method(rawValue: 1 << 26)
                                   public static let foo28Value28Called = Method(rawValue: 1 << 27)
                                   public static let foo29Value29Called = Method(rawValue: 1 << 28)
                                   public static let foo30Value30Called = Method(rawValue: 1 << 29)
                                   public static let foo31Value31Called = Method(rawValue: 1 << 30)
                                   public static let foo32Value32Called = Method(rawValue: 1 << 31)
                                   public static let foo33Value33Called = Method(rawValue: 1 << 32)
                                   public static let foo34Value34Called = Method(rawValue: 1 << 33)
                                   public static let foo35Value35Called = Method(rawValue: 1 << 34)
                                   public static let foo36Value36Called = Method(rawValue: 1 << 35)
                                   public static let foo37Value37Called = Method(rawValue: 1 << 36)
                                   public static let foo38Value38Called = Method(rawValue: 1 << 37)
                                   public static let foo39Value39Called = Method(rawValue: 1 << 38)
                                   public static let foo40Value40Called = Method(rawValue: 1 << 39)
                                   public static let foo41Value41Called = Method(rawValue: 1 << 40)
                                   public static let foo42Value42Called = Method(rawValue: 1 << 41)
                                   public static let foo43Value43Called = Method(rawValue: 1 << 42)
                                   public static let foo44Value44Called = Method(rawValue: 1 << 43)
                                   public static let foo45Value45Called = Method(rawValue: 1 << 44)
                                   public static let foo46Value46Called = Method(rawValue: 1 << 45)
                                   public static let foo47Value47Called = Method(rawValue: 1 << 46)
                                   public static let foo48Value48Called = Method(rawValue: 1 << 47)
                                   public static let foo49Value49Called = Method(rawValue: 1 << 48)
                                   public static let foo50Value50Called = Method(rawValue: 1 << 49)
                                   public static let foo51Value51Called = Method(rawValue: 1 << 50)
                                   public static let foo52Value52Called = Method(rawValue: 1 << 51)
                                   public static let foo53Value53Called = Method(rawValue: 1 << 52)
                                   public static let foo54Value54Called = Method(rawValue: 1 << 53)
                                   public static let foo55Value55Called = Method(rawValue: 1 << 54)
                                   public static let foo56Value56Called = Method(rawValue: 1 << 55)
                                   public static let foo57Value57Called = Method(rawValue: 1 << 56)
                                   public static let foo58Value58Called = Method(rawValue: 1 << 57)
                                   public static let foo59Value59Called = Method(rawValue: 1 << 58)
                                   public static let foo60Value60Called = Method(rawValue: 1 << 59)
                                   public static let foo61Value61Called = Method(rawValue: 1 << 60)
                                   public static let foo62Value62Called = Method(rawValue: 1 << 61)
                                   public static let foo63Value63Called = Method(rawValue: 1 << 62)
                                   public static let foo64Value64Called = Method(rawValue: 1 << 63)
                                   public static let foo65Value65Called = Method(rawValue: 1 << 64)
                                   public static let foo66Value66Called = Method(rawValue: 1 << 65)
                                   public static let foo67Value67Called = Method(rawValue: 1 << 66)
                                   public static let foo68Value68Called = Method(rawValue: 1 << 67)
                                   public static let foo69Value69Called = Method(rawValue: 1 << 68)
                                   public static let foo70Value70Called = Method(rawValue: 1 << 69)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt  // TODO: Increase the size of OptionSet storage. There are more options (70) than bits (64).
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let value1 = MethodParameter(rawValue: 1 << 0)
                                   public static let value2 = MethodParameter(rawValue: 1 << 1)
                                   public static let value3 = MethodParameter(rawValue: 1 << 2)
                                   public static let value4 = MethodParameter(rawValue: 1 << 3)
                                   public static let value5 = MethodParameter(rawValue: 1 << 4)
                                   public static let value6 = MethodParameter(rawValue: 1 << 5)
                                   public static let value7 = MethodParameter(rawValue: 1 << 6)
                                   public static let value8 = MethodParameter(rawValue: 1 << 7)
                                   public static let value9 = MethodParameter(rawValue: 1 << 8)
                                   public static let value10Parameter = MethodParameter(rawValue: 1 << 9)
                                   public static let value11 = MethodParameter(rawValue: 1 << 10)
                                   public static let value12 = MethodParameter(rawValue: 1 << 11)
                                   public static let value13 = MethodParameter(rawValue: 1 << 12)
                                   public static let value14 = MethodParameter(rawValue: 1 << 13)
                                   public static let value15 = MethodParameter(rawValue: 1 << 14)
                                   public static let value16 = MethodParameter(rawValue: 1 << 15)
                                   public static let value17 = MethodParameter(rawValue: 1 << 16)
                                   public static let value18 = MethodParameter(rawValue: 1 << 17)
                                   public static let value19 = MethodParameter(rawValue: 1 << 18)
                                   public static let value20 = MethodParameter(rawValue: 1 << 19)
                                   public static let value21Parameter = MethodParameter(rawValue: 1 << 20)
                                   public static let value22 = MethodParameter(rawValue: 1 << 21)
                                   public static let value23 = MethodParameter(rawValue: 1 << 22)
                                   public static let value24 = MethodParameter(rawValue: 1 << 23)
                                   public static let value25 = MethodParameter(rawValue: 1 << 24)
                                   public static let value26 = MethodParameter(rawValue: 1 << 25)
                                   public static let value27 = MethodParameter(rawValue: 1 << 26)
                                   public static let value28 = MethodParameter(rawValue: 1 << 27)
                                   public static let value29 = MethodParameter(rawValue: 1 << 28)
                                   public static let value30 = MethodParameter(rawValue: 1 << 29)
                                   public static let value31 = MethodParameter(rawValue: 1 << 30)
                                   public static let value32Parameter = MethodParameter(rawValue: 1 << 31)
                                   public static let value33 = MethodParameter(rawValue: 1 << 32)
                                   public static let value34 = MethodParameter(rawValue: 1 << 33)
                                   public static let value35 = MethodParameter(rawValue: 1 << 34)
                                   public static let value36 = MethodParameter(rawValue: 1 << 35)
                                   public static let value37 = MethodParameter(rawValue: 1 << 36)
                                   public static let value38 = MethodParameter(rawValue: 1 << 37)
                                   public static let value39 = MethodParameter(rawValue: 1 << 38)
                                   public static let value40 = MethodParameter(rawValue: 1 << 39)
                                   public static let value41 = MethodParameter(rawValue: 1 << 40)
                                   public static let value42 = MethodParameter(rawValue: 1 << 41)
                                   public static let value43Parameter = MethodParameter(rawValue: 1 << 42)
                                   public static let value44 = MethodParameter(rawValue: 1 << 43)
                                   public static let value45 = MethodParameter(rawValue: 1 << 44)
                                   public static let value46 = MethodParameter(rawValue: 1 << 45)
                                   public static let value47 = MethodParameter(rawValue: 1 << 46)
                                   public static let value48 = MethodParameter(rawValue: 1 << 47)
                                   public static let value49 = MethodParameter(rawValue: 1 << 48)
                                   public static let value50 = MethodParameter(rawValue: 1 << 49)
                                   public static let value51 = MethodParameter(rawValue: 1 << 50)
                                   public static let value52 = MethodParameter(rawValue: 1 << 51)
                                   public static let value53 = MethodParameter(rawValue: 1 << 52)
                                   public static let value54 = MethodParameter(rawValue: 1 << 53)
                                   public static let value55 = MethodParameter(rawValue: 1 << 54)
                                   public static let value56 = MethodParameter(rawValue: 1 << 55)
                                   public static let value57 = MethodParameter(rawValue: 1 << 56)
                                   public static let value58 = MethodParameter(rawValue: 1 << 57)
                                   public static let value59 = MethodParameter(rawValue: 1 << 58)
                                   public static let value60 = MethodParameter(rawValue: 1 << 59)
                                   public static let value61 = MethodParameter(rawValue: 1 << 60)
                                   public static let value62 = MethodParameter(rawValue: 1 << 61)
                                   public static let value63 = MethodParameter(rawValue: 1 << 62)
                                   public static let value64 = MethodParameter(rawValue: 1 << 63)
                                   public static let value65 = MethodParameter(rawValue: 1 << 64)
                                   public static let value66 = MethodParameter(rawValue: 1 << 65)
                                   public static let value67 = MethodParameter(rawValue: 1 << 66)
                                   public static let value68 = MethodParameter(rawValue: 1 << 67)
                                   public static let value69 = MethodParameter(rawValue: 1 << 68)
                                   public static let value70 = MethodParameter(rawValue: 1 << 69)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var value1: Int?
                               private(set) public var value2: Int?
                               private(set) public var value3: Int?
                               private(set) public var value4: Int?
                               private(set) public var value5: Int?
                               private(set) public var value6: Int?
                               private(set) public var value7: Int?
                               private(set) public var value8: Int?
                               private(set) public var value9: Int?
                               private(set) public var value10Parameter: Int?
                               private(set) public var value11: Int?
                               private(set) public var value12: Int?
                               private(set) public var value13: Int?
                               private(set) public var value14: Int?
                               private(set) public var value15: Int?
                               private(set) public var value16: Int?
                               private(set) public var value17: Int?
                               private(set) public var value18: Int?
                               private(set) public var value19: Int?
                               private(set) public var value20: Int?
                               private(set) public var value21Parameter: Int?
                               private(set) public var value22: Int?
                               private(set) public var value23: Int?
                               private(set) public var value24: Int?
                               private(set) public var value25: Int?
                               private(set) public var value26: Int?
                               private(set) public var value27: Int?
                               private(set) public var value28: Int?
                               private(set) public var value29: Int?
                               private(set) public var value30: Int?
                               private(set) public var value31: Int?
                               private(set) public var value32Parameter: Int?
                               private(set) public var value33: Int?
                               private(set) public var value34: Int?
                               private(set) public var value35: Int?
                               private(set) public var value36: Int?
                               private(set) public var value37: Int?
                               private(set) public var value38: Int?
                               private(set) public var value39: Int?
                               private(set) public var value40: Int?
                               private(set) public var value41: Int?
                               private(set) public var value42: Int?
                               private(set) public var value43Parameter: Int?
                               private(set) public var value44: Int?
                               private(set) public var value45: Int?
                               private(set) public var value46: Int?
                               private(set) public var value47: Int?
                               private(set) public var value48: Int?
                               private(set) public var value49: Int?
                               private(set) public var value50: Int?
                               private(set) public var value51: Int?
                               private(set) public var value52: Int?
                               private(set) public var value53: Int?
                               private(set) public var value54: Int?
                               private(set) public var value55: Int?
                               private(set) public var value56: Int?
                               private(set) public var value57: Int?
                               private(set) public var value58: Int?
                               private(set) public var value59: Int?
                               private(set) public var value60: Int?
                               private(set) public var value61: Int?
                               private(set) public var value62: Int?
                               private(set) public var value63: Int?
                               private(set) public var value64: Int?
                               private(set) public var value65: Int?
                               private(set) public var value66: Int?
                               private(set) public var value67: Int?
                               private(set) public var value68: Int?
                               private(set) public var value69: Int?
                               private(set) public var value70: Int?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   value1 = nil
                                   value2 = nil
                                   value3 = nil
                                   value4 = nil
                                   value5 = nil
                                   value6 = nil
                                   value7 = nil
                                   value8 = nil
                                   value9 = nil
                                   value10Parameter = nil
                                   value11 = nil
                                   value12 = nil
                                   value13 = nil
                                   value14 = nil
                                   value15 = nil
                                   value16 = nil
                                   value17 = nil
                                   value18 = nil
                                   value19 = nil
                                   value20 = nil
                                   value21Parameter = nil
                                   value22 = nil
                                   value23 = nil
                                   value24 = nil
                                   value25 = nil
                                   value26 = nil
                                   value27 = nil
                                   value28 = nil
                                   value29 = nil
                                   value30 = nil
                                   value31 = nil
                                   value32Parameter = nil
                                   value33 = nil
                                   value34 = nil
                                   value35 = nil
                                   value36 = nil
                                   value37 = nil
                                   value38 = nil
                                   value39 = nil
                                   value40 = nil
                                   value41 = nil
                                   value42 = nil
                                   value43Parameter = nil
                                   value44 = nil
                                   value45 = nil
                                   value46 = nil
                                   value47 = nil
                                   value48 = nil
                                   value49 = nil
                                   value50 = nil
                                   value51 = nil
                                   value52 = nil
                                   value53 = nil
                                   value54 = nil
                                   value55 = nil
                                   value56 = nil
                                   value57 = nil
                                   value58 = nil
                                   value59 = nil
                                   value60 = nil
                                   value61 = nil
                                   value62 = nil
                                   value63 = nil
                                   value64 = nil
                                   value65 = nil
                                   value66 = nil
                                   value67 = nil
                                   value68 = nil
                                   value69 = nil
                                   value70 = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo1(_ value1: Int) {
                                   calledMethods.insert(.foo1Value1Called)
                                   self.value1 = value1
                                   assignedParameters.insert(.value1)
                               }

                               public func foo2(_ value2: Int) {
                                   calledMethods.insert(.foo2Value2Called)
                                   self.value2 = value2
                                   assignedParameters.insert(.value2)
                               }

                               public func foo3(_ value3: Int) {
                                   calledMethods.insert(.foo3Value3Called)
                                   self.value3 = value3
                                   assignedParameters.insert(.value3)
                               }

                               public func foo4(_ value4: Int) {
                                   calledMethods.insert(.foo4Value4Called)
                                   self.value4 = value4
                                   assignedParameters.insert(.value4)
                               }

                               public func foo5(_ value5: Int) {
                                   calledMethods.insert(.foo5Value5Called)
                                   self.value5 = value5
                                   assignedParameters.insert(.value5)
                               }

                               public func foo6(_ value6: Int) {
                                   calledMethods.insert(.foo6Value6Called)
                                   self.value6 = value6
                                   assignedParameters.insert(.value6)
                               }

                               public func foo7(_ value7: Int) {
                                   calledMethods.insert(.foo7Value7Called)
                                   self.value7 = value7
                                   assignedParameters.insert(.value7)
                               }

                               public func foo8(_ value8: Int) {
                                   calledMethods.insert(.foo8Value8Called)
                                   self.value8 = value8
                                   assignedParameters.insert(.value8)
                               }

                               public func foo9(_ value9: Int) {
                                   calledMethods.insert(.foo9Value9Called)
                                   self.value9 = value9
                                   assignedParameters.insert(.value9)
                               }

                               public func foo10(_ value10: Int) {
                                   calledMethods.insert(.foo10Value10Called)
                                   self.value10Parameter = value10
                                   assignedParameters.insert(.value10Parameter)
                               }

                               public func foo11(_ value11: Int) {
                                   calledMethods.insert(.foo11Value11Called)
                                   self.value11 = value11
                                   assignedParameters.insert(.value11)
                               }

                               public func foo12(_ value12: Int) {
                                   calledMethods.insert(.foo12Value12Called)
                                   self.value12 = value12
                                   assignedParameters.insert(.value12)
                               }

                               public func foo13(_ value13: Int) {
                                   calledMethods.insert(.foo13Value13Called)
                                   self.value13 = value13
                                   assignedParameters.insert(.value13)
                               }

                               public func foo14(_ value14: Int) {
                                   calledMethods.insert(.foo14Value14Called)
                                   self.value14 = value14
                                   assignedParameters.insert(.value14)
                               }

                               public func foo15(_ value15: Int) {
                                   calledMethods.insert(.foo15Value15Called)
                                   self.value15 = value15
                                   assignedParameters.insert(.value15)
                               }

                               public func foo16(_ value16: Int) {
                                   calledMethods.insert(.foo16Value16Called)
                                   self.value16 = value16
                                   assignedParameters.insert(.value16)
                               }

                               public func foo17(_ value17: Int) {
                                   calledMethods.insert(.foo17Value17Called)
                                   self.value17 = value17
                                   assignedParameters.insert(.value17)
                               }

                               public func foo18(_ value18: Int) {
                                   calledMethods.insert(.foo18Value18Called)
                                   self.value18 = value18
                                   assignedParameters.insert(.value18)
                               }

                               public func foo19(_ value19: Int) {
                                   calledMethods.insert(.foo19Value19Called)
                                   self.value19 = value19
                                   assignedParameters.insert(.value19)
                               }

                               public func foo20(_ value20: Int) {
                                   calledMethods.insert(.foo20Value20Called)
                                   self.value20 = value20
                                   assignedParameters.insert(.value20)
                               }

                               public func foo21(_ value21: Int) {
                                   calledMethods.insert(.foo21Value21Called)
                                   self.value21Parameter = value21
                                   assignedParameters.insert(.value21Parameter)
                               }

                               public func foo22(_ value22: Int) {
                                   calledMethods.insert(.foo22Value22Called)
                                   self.value22 = value22
                                   assignedParameters.insert(.value22)
                               }

                               public func foo23(_ value23: Int) {
                                   calledMethods.insert(.foo23Value23Called)
                                   self.value23 = value23
                                   assignedParameters.insert(.value23)
                               }

                               public func foo24(_ value24: Int) {
                                   calledMethods.insert(.foo24Value24Called)
                                   self.value24 = value24
                                   assignedParameters.insert(.value24)
                               }

                               public func foo25(_ value25: Int) {
                                   calledMethods.insert(.foo25Value25Called)
                                   self.value25 = value25
                                   assignedParameters.insert(.value25)
                               }

                               public func foo26(_ value26: Int) {
                                   calledMethods.insert(.foo26Value26Called)
                                   self.value26 = value26
                                   assignedParameters.insert(.value26)
                               }

                               public func foo27(_ value27: Int) {
                                   calledMethods.insert(.foo27Value27Called)
                                   self.value27 = value27
                                   assignedParameters.insert(.value27)
                               }

                               public func foo28(_ value28: Int) {
                                   calledMethods.insert(.foo28Value28Called)
                                   self.value28 = value28
                                   assignedParameters.insert(.value28)
                               }

                               public func foo29(_ value29: Int) {
                                   calledMethods.insert(.foo29Value29Called)
                                   self.value29 = value29
                                   assignedParameters.insert(.value29)
                               }

                               public func foo30(_ value30: Int) {
                                   calledMethods.insert(.foo30Value30Called)
                                   self.value30 = value30
                                   assignedParameters.insert(.value30)
                               }

                               public func foo31(_ value31: Int) {
                                   calledMethods.insert(.foo31Value31Called)
                                   self.value31 = value31
                                   assignedParameters.insert(.value31)
                               }

                               public func foo32(_ value32: Int) {
                                   calledMethods.insert(.foo32Value32Called)
                                   self.value32Parameter = value32
                                   assignedParameters.insert(.value32Parameter)
                               }

                               public func foo33(_ value33: Int) {
                                   calledMethods.insert(.foo33Value33Called)
                                   self.value33 = value33
                                   assignedParameters.insert(.value33)
                               }

                               public func foo34(_ value34: Int) {
                                   calledMethods.insert(.foo34Value34Called)
                                   self.value34 = value34
                                   assignedParameters.insert(.value34)
                               }

                               public func foo35(_ value35: Int) {
                                   calledMethods.insert(.foo35Value35Called)
                                   self.value35 = value35
                                   assignedParameters.insert(.value35)
                               }

                               public func foo36(_ value36: Int) {
                                   calledMethods.insert(.foo36Value36Called)
                                   self.value36 = value36
                                   assignedParameters.insert(.value36)
                               }

                               public func foo37(_ value37: Int) {
                                   calledMethods.insert(.foo37Value37Called)
                                   self.value37 = value37
                                   assignedParameters.insert(.value37)
                               }

                               public func foo38(_ value38: Int) {
                                   calledMethods.insert(.foo38Value38Called)
                                   self.value38 = value38
                                   assignedParameters.insert(.value38)
                               }

                               public func foo39(_ value39: Int) {
                                   calledMethods.insert(.foo39Value39Called)
                                   self.value39 = value39
                                   assignedParameters.insert(.value39)
                               }

                               public func foo40(_ value40: Int) {
                                   calledMethods.insert(.foo40Value40Called)
                                   self.value40 = value40
                                   assignedParameters.insert(.value40)
                               }

                               public func foo41(_ value41: Int) {
                                   calledMethods.insert(.foo41Value41Called)
                                   self.value41 = value41
                                   assignedParameters.insert(.value41)
                               }

                               public func foo42(_ value42: Int) {
                                   calledMethods.insert(.foo42Value42Called)
                                   self.value42 = value42
                                   assignedParameters.insert(.value42)
                               }

                               public func foo43(_ value43: Int) {
                                   calledMethods.insert(.foo43Value43Called)
                                   self.value43Parameter = value43
                                   assignedParameters.insert(.value43Parameter)
                               }

                               public func foo44(_ value44: Int) {
                                   calledMethods.insert(.foo44Value44Called)
                                   self.value44 = value44
                                   assignedParameters.insert(.value44)
                               }

                               public func foo45(_ value45: Int) {
                                   calledMethods.insert(.foo45Value45Called)
                                   self.value45 = value45
                                   assignedParameters.insert(.value45)
                               }

                               public func foo46(_ value46: Int) {
                                   calledMethods.insert(.foo46Value46Called)
                                   self.value46 = value46
                                   assignedParameters.insert(.value46)
                               }

                               public func foo47(_ value47: Int) {
                                   calledMethods.insert(.foo47Value47Called)
                                   self.value47 = value47
                                   assignedParameters.insert(.value47)
                               }

                               public func foo48(_ value48: Int) {
                                   calledMethods.insert(.foo48Value48Called)
                                   self.value48 = value48
                                   assignedParameters.insert(.value48)
                               }

                               public func foo49(_ value49: Int) {
                                   calledMethods.insert(.foo49Value49Called)
                                   self.value49 = value49
                                   assignedParameters.insert(.value49)
                               }

                               public func foo50(_ value50: Int) {
                                   calledMethods.insert(.foo50Value50Called)
                                   self.value50 = value50
                                   assignedParameters.insert(.value50)
                               }

                               public func foo51(_ value51: Int) {
                                   calledMethods.insert(.foo51Value51Called)
                                   self.value51 = value51
                                   assignedParameters.insert(.value51)
                               }

                               public func foo52(_ value52: Int) {
                                   calledMethods.insert(.foo52Value52Called)
                                   self.value52 = value52
                                   assignedParameters.insert(.value52)
                               }

                               public func foo53(_ value53: Int) {
                                   calledMethods.insert(.foo53Value53Called)
                                   self.value53 = value53
                                   assignedParameters.insert(.value53)
                               }

                               public func foo54(_ value54: Int) {
                                   calledMethods.insert(.foo54Value54Called)
                                   self.value54 = value54
                                   assignedParameters.insert(.value54)
                               }

                               public func foo55(_ value55: Int) {
                                   calledMethods.insert(.foo55Value55Called)
                                   self.value55 = value55
                                   assignedParameters.insert(.value55)
                               }

                               public func foo56(_ value56: Int) {
                                   calledMethods.insert(.foo56Value56Called)
                                   self.value56 = value56
                                   assignedParameters.insert(.value56)
                               }

                               public func foo57(_ value57: Int) {
                                   calledMethods.insert(.foo57Value57Called)
                                   self.value57 = value57
                                   assignedParameters.insert(.value57)
                               }

                               public func foo58(_ value58: Int) {
                                   calledMethods.insert(.foo58Value58Called)
                                   self.value58 = value58
                                   assignedParameters.insert(.value58)
                               }

                               public func foo59(_ value59: Int) {
                                   calledMethods.insert(.foo59Value59Called)
                                   self.value59 = value59
                                   assignedParameters.insert(.value59)
                               }

                               public func foo60(_ value60: Int) {
                                   calledMethods.insert(.foo60Value60Called)
                                   self.value60 = value60
                                   assignedParameters.insert(.value60)
                               }

                               public func foo61(_ value61: Int) {
                                   calledMethods.insert(.foo61Value61Called)
                                   self.value61 = value61
                                   assignedParameters.insert(.value61)
                               }

                               public func foo62(_ value62: Int) {
                                   calledMethods.insert(.foo62Value62Called)
                                   self.value62 = value62
                                   assignedParameters.insert(.value62)
                               }

                               public func foo63(_ value63: Int) {
                                   calledMethods.insert(.foo63Value63Called)
                                   self.value63 = value63
                                   assignedParameters.insert(.value63)
                               }

                               public func foo64(_ value64: Int) {
                                   calledMethods.insert(.foo64Value64Called)
                                   self.value64 = value64
                                   assignedParameters.insert(.value64)
                               }

                               public func foo65(_ value65: Int) {
                                   calledMethods.insert(.foo65Value65Called)
                                   self.value65 = value65
                                   assignedParameters.insert(.value65)
                               }

                               public func foo66(_ value66: Int) {
                                   calledMethods.insert(.foo66Value66Called)
                                   self.value66 = value66
                                   assignedParameters.insert(.value66)
                               }

                               public func foo67(_ value67: Int) {
                                   calledMethods.insert(.foo67Value67Called)
                                   self.value67 = value67
                                   assignedParameters.insert(.value67)
                               }

                               public func foo68(_ value68: Int) {
                                   calledMethods.insert(.foo68Value68Called)
                                   self.value68 = value68
                                   assignedParameters.insert(.value68)
                               }

                               public func foo69(_ value69: Int) {
                                   calledMethods.insert(.foo69Value69Called)
                                   self.value69 = value69
                                   assignedParameters.insert(.value69)
                               }

                               public func foo70(_ value70: Int) {
                                   calledMethods.insert(.foo70Value70Called)
                                   self.value70 = value70
                                   assignedParameters.insert(.value70)
                               }

                           }

                           extension MockTest.Method: CustomStringConvertible {
                               public var description: String {
                                   var value = "["
                                   var first = true
                                   func handleFirst() {
                                       if first {
                                           first = false
                                       } else {
                                           value += ", "
                                       }
                                   }

                                   if self.contains(.foo1Value1Called) {
                                       handleFirst()
                                       value += ".foo1Value1Called"
                                   }
                                   if self.contains(.foo2Value2Called) {
                                       handleFirst()
                                       value += ".foo2Value2Called"
                                   }
                                   if self.contains(.foo3Value3Called) {
                                       handleFirst()
                                       value += ".foo3Value3Called"
                                   }
                                   if self.contains(.foo4Value4Called) {
                                       handleFirst()
                                       value += ".foo4Value4Called"
                                   }
                                   if self.contains(.foo5Value5Called) {
                                       handleFirst()
                                       value += ".foo5Value5Called"
                                   }
                                   if self.contains(.foo6Value6Called) {
                                       handleFirst()
                                       value += ".foo6Value6Called"
                                   }
                                   if self.contains(.foo7Value7Called) {
                                       handleFirst()
                                       value += ".foo7Value7Called"
                                   }
                                   if self.contains(.foo8Value8Called) {
                                       handleFirst()
                                       value += ".foo8Value8Called"
                                   }
                                   if self.contains(.foo9Value9Called) {
                                       handleFirst()
                                       value += ".foo9Value9Called"
                                   }
                                   if self.contains(.foo10Value10Called) {
                                       handleFirst()
                                       value += ".foo10Value10Called"
                                   }
                                   if self.contains(.foo11Value11Called) {
                                       handleFirst()
                                       value += ".foo11Value11Called"
                                   }
                                   if self.contains(.foo12Value12Called) {
                                       handleFirst()
                                       value += ".foo12Value12Called"
                                   }
                                   if self.contains(.foo13Value13Called) {
                                       handleFirst()
                                       value += ".foo13Value13Called"
                                   }
                                   if self.contains(.foo14Value14Called) {
                                       handleFirst()
                                       value += ".foo14Value14Called"
                                   }
                                   if self.contains(.foo15Value15Called) {
                                       handleFirst()
                                       value += ".foo15Value15Called"
                                   }
                                   if self.contains(.foo16Value16Called) {
                                       handleFirst()
                                       value += ".foo16Value16Called"
                                   }
                                   if self.contains(.foo17Value17Called) {
                                       handleFirst()
                                       value += ".foo17Value17Called"
                                   }
                                   if self.contains(.foo18Value18Called) {
                                       handleFirst()
                                       value += ".foo18Value18Called"
                                   }
                                   if self.contains(.foo19Value19Called) {
                                       handleFirst()
                                       value += ".foo19Value19Called"
                                   }
                                   if self.contains(.foo20Value20Called) {
                                       handleFirst()
                                       value += ".foo20Value20Called"
                                   }
                                   if self.contains(.foo21Value21Called) {
                                       handleFirst()
                                       value += ".foo21Value21Called"
                                   }
                                   if self.contains(.foo22Value22Called) {
                                       handleFirst()
                                       value += ".foo22Value22Called"
                                   }
                                   if self.contains(.foo23Value23Called) {
                                       handleFirst()
                                       value += ".foo23Value23Called"
                                   }
                                   if self.contains(.foo24Value24Called) {
                                       handleFirst()
                                       value += ".foo24Value24Called"
                                   }
                                   if self.contains(.foo25Value25Called) {
                                       handleFirst()
                                       value += ".foo25Value25Called"
                                   }
                                   if self.contains(.foo26Value26Called) {
                                       handleFirst()
                                       value += ".foo26Value26Called"
                                   }
                                   if self.contains(.foo27Value27Called) {
                                       handleFirst()
                                       value += ".foo27Value27Called"
                                   }
                                   if self.contains(.foo28Value28Called) {
                                       handleFirst()
                                       value += ".foo28Value28Called"
                                   }
                                   if self.contains(.foo29Value29Called) {
                                       handleFirst()
                                       value += ".foo29Value29Called"
                                   }
                                   if self.contains(.foo30Value30Called) {
                                       handleFirst()
                                       value += ".foo30Value30Called"
                                   }
                                   if self.contains(.foo31Value31Called) {
                                       handleFirst()
                                       value += ".foo31Value31Called"
                                   }
                                   if self.contains(.foo32Value32Called) {
                                       handleFirst()
                                       value += ".foo32Value32Called"
                                   }
                                   if self.contains(.foo33Value33Called) {
                                       handleFirst()
                                       value += ".foo33Value33Called"
                                   }
                                   if self.contains(.foo34Value34Called) {
                                       handleFirst()
                                       value += ".foo34Value34Called"
                                   }
                                   if self.contains(.foo35Value35Called) {
                                       handleFirst()
                                       value += ".foo35Value35Called"
                                   }
                                   if self.contains(.foo36Value36Called) {
                                       handleFirst()
                                       value += ".foo36Value36Called"
                                   }
                                   if self.contains(.foo37Value37Called) {
                                       handleFirst()
                                       value += ".foo37Value37Called"
                                   }
                                   if self.contains(.foo38Value38Called) {
                                       handleFirst()
                                       value += ".foo38Value38Called"
                                   }
                                   if self.contains(.foo39Value39Called) {
                                       handleFirst()
                                       value += ".foo39Value39Called"
                                   }
                                   if self.contains(.foo40Value40Called) {
                                       handleFirst()
                                       value += ".foo40Value40Called"
                                   }
                                   if self.contains(.foo41Value41Called) {
                                       handleFirst()
                                       value += ".foo41Value41Called"
                                   }
                                   if self.contains(.foo42Value42Called) {
                                       handleFirst()
                                       value += ".foo42Value42Called"
                                   }
                                   if self.contains(.foo43Value43Called) {
                                       handleFirst()
                                       value += ".foo43Value43Called"
                                   }
                                   if self.contains(.foo44Value44Called) {
                                       handleFirst()
                                       value += ".foo44Value44Called"
                                   }
                                   if self.contains(.foo45Value45Called) {
                                       handleFirst()
                                       value += ".foo45Value45Called"
                                   }
                                   if self.contains(.foo46Value46Called) {
                                       handleFirst()
                                       value += ".foo46Value46Called"
                                   }
                                   if self.contains(.foo47Value47Called) {
                                       handleFirst()
                                       value += ".foo47Value47Called"
                                   }
                                   if self.contains(.foo48Value48Called) {
                                       handleFirst()
                                       value += ".foo48Value48Called"
                                   }
                                   if self.contains(.foo49Value49Called) {
                                       handleFirst()
                                       value += ".foo49Value49Called"
                                   }
                                   if self.contains(.foo50Value50Called) {
                                       handleFirst()
                                       value += ".foo50Value50Called"
                                   }
                                   if self.contains(.foo51Value51Called) {
                                       handleFirst()
                                       value += ".foo51Value51Called"
                                   }
                                   if self.contains(.foo52Value52Called) {
                                       handleFirst()
                                       value += ".foo52Value52Called"
                                   }
                                   if self.contains(.foo53Value53Called) {
                                       handleFirst()
                                       value += ".foo53Value53Called"
                                   }
                                   if self.contains(.foo54Value54Called) {
                                       handleFirst()
                                       value += ".foo54Value54Called"
                                   }
                                   if self.contains(.foo55Value55Called) {
                                       handleFirst()
                                       value += ".foo55Value55Called"
                                   }
                                   if self.contains(.foo56Value56Called) {
                                       handleFirst()
                                       value += ".foo56Value56Called"
                                   }
                                   if self.contains(.foo57Value57Called) {
                                       handleFirst()
                                       value += ".foo57Value57Called"
                                   }
                                   if self.contains(.foo58Value58Called) {
                                       handleFirst()
                                       value += ".foo58Value58Called"
                                   }
                                   if self.contains(.foo59Value59Called) {
                                       handleFirst()
                                       value += ".foo59Value59Called"
                                   }
                                   if self.contains(.foo60Value60Called) {
                                       handleFirst()
                                       value += ".foo60Value60Called"
                                   }
                                   if self.contains(.foo61Value61Called) {
                                       handleFirst()
                                       value += ".foo61Value61Called"
                                   }
                                   if self.contains(.foo62Value62Called) {
                                       handleFirst()
                                       value += ".foo62Value62Called"
                                   }
                                   if self.contains(.foo63Value63Called) {
                                       handleFirst()
                                       value += ".foo63Value63Called"
                                   }
                                   if self.contains(.foo64Value64Called) {
                                       handleFirst()
                                       value += ".foo64Value64Called"
                                   }
                                   if self.contains(.foo65Value65Called) {
                                       handleFirst()
                                       value += ".foo65Value65Called"
                                   }
                                   if self.contains(.foo66Value66Called) {
                                       handleFirst()
                                       value += ".foo66Value66Called"
                                   }
                                   if self.contains(.foo67Value67Called) {
                                       handleFirst()
                                       value += ".foo67Value67Called"
                                   }
                                   if self.contains(.foo68Value68Called) {
                                       handleFirst()
                                       value += ".foo68Value68Called"
                                   }
                                   if self.contains(.foo69Value69Called) {
                                       handleFirst()
                                       value += ".foo69Value69Called"
                                   }
                                   if self.contains(.foo70Value70Called) {
                                       handleFirst()
                                       value += ".foo70Value70Called"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest.MethodParameter: CustomStringConvertible {
                               public var description: String {
                                   var value = "["
                                   var first = true
                                   func handleFirst() {
                                       if first {
                                           first = false
                                       } else {
                                           value += ", "
                                       }
                                   }

                                   if self.contains(.value1) {
                                       handleFirst()
                                       value += ".value1"
                                   }
                                   if self.contains(.value2) {
                                       handleFirst()
                                       value += ".value2"
                                   }
                                   if self.contains(.value3) {
                                       handleFirst()
                                       value += ".value3"
                                   }
                                   if self.contains(.value4) {
                                       handleFirst()
                                       value += ".value4"
                                   }
                                   if self.contains(.value5) {
                                       handleFirst()
                                       value += ".value5"
                                   }
                                   if self.contains(.value6) {
                                       handleFirst()
                                       value += ".value6"
                                   }
                                   if self.contains(.value7) {
                                       handleFirst()
                                       value += ".value7"
                                   }
                                   if self.contains(.value8) {
                                       handleFirst()
                                       value += ".value8"
                                   }
                                   if self.contains(.value9) {
                                       handleFirst()
                                       value += ".value9"
                                   }
                                   if self.contains(.value10Parameter) {
                                       handleFirst()
                                       value += ".value10Parameter"
                                   }
                                   if self.contains(.value11) {
                                       handleFirst()
                                       value += ".value11"
                                   }
                                   if self.contains(.value12) {
                                       handleFirst()
                                       value += ".value12"
                                   }
                                   if self.contains(.value13) {
                                       handleFirst()
                                       value += ".value13"
                                   }
                                   if self.contains(.value14) {
                                       handleFirst()
                                       value += ".value14"
                                   }
                                   if self.contains(.value15) {
                                       handleFirst()
                                       value += ".value15"
                                   }
                                   if self.contains(.value16) {
                                       handleFirst()
                                       value += ".value16"
                                   }
                                   if self.contains(.value17) {
                                       handleFirst()
                                       value += ".value17"
                                   }
                                   if self.contains(.value18) {
                                       handleFirst()
                                       value += ".value18"
                                   }
                                   if self.contains(.value19) {
                                       handleFirst()
                                       value += ".value19"
                                   }
                                   if self.contains(.value20) {
                                       handleFirst()
                                       value += ".value20"
                                   }
                                   if self.contains(.value21Parameter) {
                                       handleFirst()
                                       value += ".value21Parameter"
                                   }
                                   if self.contains(.value22) {
                                       handleFirst()
                                       value += ".value22"
                                   }
                                   if self.contains(.value23) {
                                       handleFirst()
                                       value += ".value23"
                                   }
                                   if self.contains(.value24) {
                                       handleFirst()
                                       value += ".value24"
                                   }
                                   if self.contains(.value25) {
                                       handleFirst()
                                       value += ".value25"
                                   }
                                   if self.contains(.value26) {
                                       handleFirst()
                                       value += ".value26"
                                   }
                                   if self.contains(.value27) {
                                       handleFirst()
                                       value += ".value27"
                                   }
                                   if self.contains(.value28) {
                                       handleFirst()
                                       value += ".value28"
                                   }
                                   if self.contains(.value29) {
                                       handleFirst()
                                       value += ".value29"
                                   }
                                   if self.contains(.value30) {
                                       handleFirst()
                                       value += ".value30"
                                   }
                                   if self.contains(.value31) {
                                       handleFirst()
                                       value += ".value31"
                                   }
                                   if self.contains(.value32Parameter) {
                                       handleFirst()
                                       value += ".value32Parameter"
                                   }
                                   if self.contains(.value33) {
                                       handleFirst()
                                       value += ".value33"
                                   }
                                   if self.contains(.value34) {
                                       handleFirst()
                                       value += ".value34"
                                   }
                                   if self.contains(.value35) {
                                       handleFirst()
                                       value += ".value35"
                                   }
                                   if self.contains(.value36) {
                                       handleFirst()
                                       value += ".value36"
                                   }
                                   if self.contains(.value37) {
                                       handleFirst()
                                       value += ".value37"
                                   }
                                   if self.contains(.value38) {
                                       handleFirst()
                                       value += ".value38"
                                   }
                                   if self.contains(.value39) {
                                       handleFirst()
                                       value += ".value39"
                                   }
                                   if self.contains(.value40) {
                                       handleFirst()
                                       value += ".value40"
                                   }
                                   if self.contains(.value41) {
                                       handleFirst()
                                       value += ".value41"
                                   }
                                   if self.contains(.value42) {
                                       handleFirst()
                                       value += ".value42"
                                   }
                                   if self.contains(.value43Parameter) {
                                       handleFirst()
                                       value += ".value43Parameter"
                                   }
                                   if self.contains(.value44) {
                                       handleFirst()
                                       value += ".value44"
                                   }
                                   if self.contains(.value45) {
                                       handleFirst()
                                       value += ".value45"
                                   }
                                   if self.contains(.value46) {
                                       handleFirst()
                                       value += ".value46"
                                   }
                                   if self.contains(.value47) {
                                       handleFirst()
                                       value += ".value47"
                                   }
                                   if self.contains(.value48) {
                                       handleFirst()
                                       value += ".value48"
                                   }
                                   if self.contains(.value49) {
                                       handleFirst()
                                       value += ".value49"
                                   }
                                   if self.contains(.value50) {
                                       handleFirst()
                                       value += ".value50"
                                   }
                                   if self.contains(.value51) {
                                       handleFirst()
                                       value += ".value51"
                                   }
                                   if self.contains(.value52) {
                                       handleFirst()
                                       value += ".value52"
                                   }
                                   if self.contains(.value53) {
                                       handleFirst()
                                       value += ".value53"
                                   }
                                   if self.contains(.value54) {
                                       handleFirst()
                                       value += ".value54"
                                   }
                                   if self.contains(.value55) {
                                       handleFirst()
                                       value += ".value55"
                                   }
                                   if self.contains(.value56) {
                                       handleFirst()
                                       value += ".value56"
                                   }
                                   if self.contains(.value57) {
                                       handleFirst()
                                       value += ".value57"
                                   }
                                   if self.contains(.value58) {
                                       handleFirst()
                                       value += ".value58"
                                   }
                                   if self.contains(.value59) {
                                       handleFirst()
                                       value += ".value59"
                                   }
                                   if self.contains(.value60) {
                                       handleFirst()
                                       value += ".value60"
                                   }
                                   if self.contains(.value61) {
                                       handleFirst()
                                       value += ".value61"
                                   }
                                   if self.contains(.value62) {
                                       handleFirst()
                                       value += ".value62"
                                   }
                                   if self.contains(.value63) {
                                       handleFirst()
                                       value += ".value63"
                                   }
                                   if self.contains(.value64) {
                                       handleFirst()
                                       value += ".value64"
                                   }
                                   if self.contains(.value65) {
                                       handleFirst()
                                       value += ".value65"
                                   }
                                   if self.contains(.value66) {
                                       handleFirst()
                                       value += ".value66"
                                   }
                                   if self.contains(.value67) {
                                       handleFirst()
                                       value += ".value67"
                                   }
                                   if self.contains(.value68) {
                                       handleFirst()
                                       value += ".value68"
                                   }
                                   if self.contains(.value69) {
                                       handleFirst()
                                       value += ".value69"
                                   }
                                   if self.contains(.value70) {
                                       handleFirst()
                                       value += ".value70"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethodsAndAssignedParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        //printFirstDifference(code, expectedCode)  //Uncomment if needed. Too slow for regular execution
    }

    // MARK: Very Large (Too Many Methods/Input Parameters) Static Protocol
    
    var veryLargeStaticProtocol: String {
        """
        protocol VeryLargeStaticProtocol {
        
            static var a: String { get }
            static var value10: String { get set }
            static var value21: String { get set }
            static var value32: String { get set }
            static var value43: String { get set }
            static var x: Double { get set }
            static var y: [String]? { get set }
            static var z: Bool { get set }

            static func foo1()
            static func foo2(_ value2: Int)
            static func foo3(_ value3: Int)
            static func foo4(_ value4: Int)
            static func foo5(_ value5: Int)
            static func foo6(_ value6: Int)
            static func foo7(_ value7: Int)
            static func foo8(_ value8: Int)
            static func foo9(_ value9: Int)
            static func foo10(_ value10: Int)
            static func foo11(_ value11: Int)
            static func foo12(_ value12: Int)
            static func foo13(_ value13: Int)
            static func foo14(_ value14: Int)
            static func foo15(_ value15: Int)
            static func foo16(_ value16: Int)
            static func foo17(_ value17: Int)
            static func foo18(_ value18: Int)
            static func foo19(_ value19: Int)
            static func foo20(_ value20: Int)
            static func foo21(_ value21: Int)
            static func foo22(_ value22: Int)
            static func foo23(_ value23: Int)
            static func foo24(_ value24: Int)
            static func foo25(_ value25: Int)
            static func foo26(_ value26: Int)
            static func foo27(_ value27: Int)
            static func foo28(_ value28: Int)
            static func foo29(_ value29: Int)
            static func foo30(_ value30: Int)
            static func foo31(_ value31: Int)
            static func foo32(_ value32: Int)
            static func foo33(_ value33: Int)
            static func foo34(_ value34: Int)
            static func foo35(_ value35: Int)
            static func foo36(_ value36: Int)
            static func foo37(_ value37: Int)
            static func foo38(_ value38: Int)
            static func foo39(_ value39: Int)
            static func foo40(_ value40: Int)
            static func foo41(_ value41: Int)
            static func foo42(_ value42: Int)
            static func foo43(_ value43: Int)
            static func foo44(_ value44: Int)
            static func foo45(_ value45: Int)
            static func foo46(_ value46: Int)
            static func foo47(_ value47: Int)
            static func foo48(_ value48: Int)
            static func foo49(_ value49: Int)
            static func foo50()
            static func foo51(_ value51: Int)
            static func foo52(_ value52: Int)
            static func foo53(_ value53: Int)
            static func foo54(_ value54: Int)
            static func foo55(_ value55: Int)
            static func foo56(_ value56: Int)
            static func foo57(_ value57: Int)
            static func foo58(_ value58: Int)
            static func foo59(_ value59: Int)
            static func foo60(_ value60: Int)
            static func foo61(_ value61: Int)
            static func foo62(_ value62: Int)
            static func foo63(_ value63: Int)
            static func foo64(_ value64: Int)
            static func foo65(_ value65: Int)
            static func foo66(_ value66: Int)
            static func foo67(_ value67: Int)
            static func foo68(_ value68: Int)
            static func foo69(_ value69: Int)
            static func foo70()
        }
        """
    }
    
    func testCodeGeneration_veryLargeStaticProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: veryLargeStaticProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: VeryLargeStaticProtocol {

                               // MARK: - Variables for Protocol Conformance

                               static var a: String
                               static var value10: String
                               static var value21: String
                               static var value32: String
                               static var value43: String
                               static var x: Double
                               static var y: [String]?
                               static var z: Bool

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet, Sendable {
                                   let rawValue: UInt  // TODO: Increase the size of OptionSet storage. There are more options (70) than bits (64).
                                   static let foo1Called = StaticMethod(rawValue: 1 << 0)
                                   static let foo2Value2Called = StaticMethod(rawValue: 1 << 1)
                                   static let foo3Value3Called = StaticMethod(rawValue: 1 << 2)
                                   static let foo4Value4Called = StaticMethod(rawValue: 1 << 3)
                                   static let foo5Value5Called = StaticMethod(rawValue: 1 << 4)
                                   static let foo6Value6Called = StaticMethod(rawValue: 1 << 5)
                                   static let foo7Value7Called = StaticMethod(rawValue: 1 << 6)
                                   static let foo8Value8Called = StaticMethod(rawValue: 1 << 7)
                                   static let foo9Value9Called = StaticMethod(rawValue: 1 << 8)
                                   static let foo10Value10Called = StaticMethod(rawValue: 1 << 9)
                                   static let foo11Value11Called = StaticMethod(rawValue: 1 << 10)
                                   static let foo12Value12Called = StaticMethod(rawValue: 1 << 11)
                                   static let foo13Value13Called = StaticMethod(rawValue: 1 << 12)
                                   static let foo14Value14Called = StaticMethod(rawValue: 1 << 13)
                                   static let foo15Value15Called = StaticMethod(rawValue: 1 << 14)
                                   static let foo16Value16Called = StaticMethod(rawValue: 1 << 15)
                                   static let foo17Value17Called = StaticMethod(rawValue: 1 << 16)
                                   static let foo18Value18Called = StaticMethod(rawValue: 1 << 17)
                                   static let foo19Value19Called = StaticMethod(rawValue: 1 << 18)
                                   static let foo20Value20Called = StaticMethod(rawValue: 1 << 19)
                                   static let foo21Value21Called = StaticMethod(rawValue: 1 << 20)
                                   static let foo22Value22Called = StaticMethod(rawValue: 1 << 21)
                                   static let foo23Value23Called = StaticMethod(rawValue: 1 << 22)
                                   static let foo24Value24Called = StaticMethod(rawValue: 1 << 23)
                                   static let foo25Value25Called = StaticMethod(rawValue: 1 << 24)
                                   static let foo26Value26Called = StaticMethod(rawValue: 1 << 25)
                                   static let foo27Value27Called = StaticMethod(rawValue: 1 << 26)
                                   static let foo28Value28Called = StaticMethod(rawValue: 1 << 27)
                                   static let foo29Value29Called = StaticMethod(rawValue: 1 << 28)
                                   static let foo30Value30Called = StaticMethod(rawValue: 1 << 29)
                                   static let foo31Value31Called = StaticMethod(rawValue: 1 << 30)
                                   static let foo32Value32Called = StaticMethod(rawValue: 1 << 31)
                                   static let foo33Value33Called = StaticMethod(rawValue: 1 << 32)
                                   static let foo34Value34Called = StaticMethod(rawValue: 1 << 33)
                                   static let foo35Value35Called = StaticMethod(rawValue: 1 << 34)
                                   static let foo36Value36Called = StaticMethod(rawValue: 1 << 35)
                                   static let foo37Value37Called = StaticMethod(rawValue: 1 << 36)
                                   static let foo38Value38Called = StaticMethod(rawValue: 1 << 37)
                                   static let foo39Value39Called = StaticMethod(rawValue: 1 << 38)
                                   static let foo40Value40Called = StaticMethod(rawValue: 1 << 39)
                                   static let foo41Value41Called = StaticMethod(rawValue: 1 << 40)
                                   static let foo42Value42Called = StaticMethod(rawValue: 1 << 41)
                                   static let foo43Value43Called = StaticMethod(rawValue: 1 << 42)
                                   static let foo44Value44Called = StaticMethod(rawValue: 1 << 43)
                                   static let foo45Value45Called = StaticMethod(rawValue: 1 << 44)
                                   static let foo46Value46Called = StaticMethod(rawValue: 1 << 45)
                                   static let foo47Value47Called = StaticMethod(rawValue: 1 << 46)
                                   static let foo48Value48Called = StaticMethod(rawValue: 1 << 47)
                                   static let foo49Value49Called = StaticMethod(rawValue: 1 << 48)
                                   static let foo50Called = StaticMethod(rawValue: 1 << 49)
                                   static let foo51Value51Called = StaticMethod(rawValue: 1 << 50)
                                   static let foo52Value52Called = StaticMethod(rawValue: 1 << 51)
                                   static let foo53Value53Called = StaticMethod(rawValue: 1 << 52)
                                   static let foo54Value54Called = StaticMethod(rawValue: 1 << 53)
                                   static let foo55Value55Called = StaticMethod(rawValue: 1 << 54)
                                   static let foo56Value56Called = StaticMethod(rawValue: 1 << 55)
                                   static let foo57Value57Called = StaticMethod(rawValue: 1 << 56)
                                   static let foo58Value58Called = StaticMethod(rawValue: 1 << 57)
                                   static let foo59Value59Called = StaticMethod(rawValue: 1 << 58)
                                   static let foo60Value60Called = StaticMethod(rawValue: 1 << 59)
                                   static let foo61Value61Called = StaticMethod(rawValue: 1 << 60)
                                   static let foo62Value62Called = StaticMethod(rawValue: 1 << 61)
                                   static let foo63Value63Called = StaticMethod(rawValue: 1 << 62)
                                   static let foo64Value64Called = StaticMethod(rawValue: 1 << 63)
                                   static let foo65Value65Called = StaticMethod(rawValue: 1 << 64)
                                   static let foo66Value66Called = StaticMethod(rawValue: 1 << 65)
                                   static let foo67Value67Called = StaticMethod(rawValue: 1 << 66)
                                   static let foo68Value68Called = StaticMethod(rawValue: 1 << 67)
                                   static let foo69Value69Called = StaticMethod(rawValue: 1 << 68)
                                   static let foo70Called = StaticMethod(rawValue: 1 << 69)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt  // TODO: Increase the size of OptionSet storage. There are more options (67) than bits (64).
                                   static let value2 = StaticMethodParameter(rawValue: 1 << 0)
                                   static let value3 = StaticMethodParameter(rawValue: 1 << 1)
                                   static let value4 = StaticMethodParameter(rawValue: 1 << 2)
                                   static let value5 = StaticMethodParameter(rawValue: 1 << 3)
                                   static let value6 = StaticMethodParameter(rawValue: 1 << 4)
                                   static let value7 = StaticMethodParameter(rawValue: 1 << 5)
                                   static let value8 = StaticMethodParameter(rawValue: 1 << 6)
                                   static let value9 = StaticMethodParameter(rawValue: 1 << 7)
                                   static let value10Parameter = StaticMethodParameter(rawValue: 1 << 8)
                                   static let value11 = StaticMethodParameter(rawValue: 1 << 9)
                                   static let value12 = StaticMethodParameter(rawValue: 1 << 10)
                                   static let value13 = StaticMethodParameter(rawValue: 1 << 11)
                                   static let value14 = StaticMethodParameter(rawValue: 1 << 12)
                                   static let value15 = StaticMethodParameter(rawValue: 1 << 13)
                                   static let value16 = StaticMethodParameter(rawValue: 1 << 14)
                                   static let value17 = StaticMethodParameter(rawValue: 1 << 15)
                                   static let value18 = StaticMethodParameter(rawValue: 1 << 16)
                                   static let value19 = StaticMethodParameter(rawValue: 1 << 17)
                                   static let value20 = StaticMethodParameter(rawValue: 1 << 18)
                                   static let value21Parameter = StaticMethodParameter(rawValue: 1 << 19)
                                   static let value22 = StaticMethodParameter(rawValue: 1 << 20)
                                   static let value23 = StaticMethodParameter(rawValue: 1 << 21)
                                   static let value24 = StaticMethodParameter(rawValue: 1 << 22)
                                   static let value25 = StaticMethodParameter(rawValue: 1 << 23)
                                   static let value26 = StaticMethodParameter(rawValue: 1 << 24)
                                   static let value27 = StaticMethodParameter(rawValue: 1 << 25)
                                   static let value28 = StaticMethodParameter(rawValue: 1 << 26)
                                   static let value29 = StaticMethodParameter(rawValue: 1 << 27)
                                   static let value30 = StaticMethodParameter(rawValue: 1 << 28)
                                   static let value31 = StaticMethodParameter(rawValue: 1 << 29)
                                   static let value32Parameter = StaticMethodParameter(rawValue: 1 << 30)
                                   static let value33 = StaticMethodParameter(rawValue: 1 << 31)
                                   static let value34 = StaticMethodParameter(rawValue: 1 << 32)
                                   static let value35 = StaticMethodParameter(rawValue: 1 << 33)
                                   static let value36 = StaticMethodParameter(rawValue: 1 << 34)
                                   static let value37 = StaticMethodParameter(rawValue: 1 << 35)
                                   static let value38 = StaticMethodParameter(rawValue: 1 << 36)
                                   static let value39 = StaticMethodParameter(rawValue: 1 << 37)
                                   static let value40 = StaticMethodParameter(rawValue: 1 << 38)
                                   static let value41 = StaticMethodParameter(rawValue: 1 << 39)
                                   static let value42 = StaticMethodParameter(rawValue: 1 << 40)
                                   static let value43Parameter = StaticMethodParameter(rawValue: 1 << 41)
                                   static let value44 = StaticMethodParameter(rawValue: 1 << 42)
                                   static let value45 = StaticMethodParameter(rawValue: 1 << 43)
                                   static let value46 = StaticMethodParameter(rawValue: 1 << 44)
                                   static let value47 = StaticMethodParameter(rawValue: 1 << 45)
                                   static let value48 = StaticMethodParameter(rawValue: 1 << 46)
                                   static let value49 = StaticMethodParameter(rawValue: 1 << 47)
                                   static let value51 = StaticMethodParameter(rawValue: 1 << 48)
                                   static let value52 = StaticMethodParameter(rawValue: 1 << 49)
                                   static let value53 = StaticMethodParameter(rawValue: 1 << 50)
                                   static let value54 = StaticMethodParameter(rawValue: 1 << 51)
                                   static let value55 = StaticMethodParameter(rawValue: 1 << 52)
                                   static let value56 = StaticMethodParameter(rawValue: 1 << 53)
                                   static let value57 = StaticMethodParameter(rawValue: 1 << 54)
                                   static let value58 = StaticMethodParameter(rawValue: 1 << 55)
                                   static let value59 = StaticMethodParameter(rawValue: 1 << 56)
                                   static let value60 = StaticMethodParameter(rawValue: 1 << 57)
                                   static let value61 = StaticMethodParameter(rawValue: 1 << 58)
                                   static let value62 = StaticMethodParameter(rawValue: 1 << 59)
                                   static let value63 = StaticMethodParameter(rawValue: 1 << 60)
                                   static let value64 = StaticMethodParameter(rawValue: 1 << 61)
                                   static let value65 = StaticMethodParameter(rawValue: 1 << 62)
                                   static let value66 = StaticMethodParameter(rawValue: 1 << 63)
                                   static let value67 = StaticMethodParameter(rawValue: 1 << 64)
                                   static let value68 = StaticMethodParameter(rawValue: 1 << 65)
                                   static let value69 = StaticMethodParameter(rawValue: 1 << 66)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var value2: Int?
                               private(set) static var value3: Int?
                               private(set) static var value4: Int?
                               private(set) static var value5: Int?
                               private(set) static var value6: Int?
                               private(set) static var value7: Int?
                               private(set) static var value8: Int?
                               private(set) static var value9: Int?
                               private(set) static var value10Parameter: Int?
                               private(set) static var value11: Int?
                               private(set) static var value12: Int?
                               private(set) static var value13: Int?
                               private(set) static var value14: Int?
                               private(set) static var value15: Int?
                               private(set) static var value16: Int?
                               private(set) static var value17: Int?
                               private(set) static var value18: Int?
                               private(set) static var value19: Int?
                               private(set) static var value20: Int?
                               private(set) static var value21Parameter: Int?
                               private(set) static var value22: Int?
                               private(set) static var value23: Int?
                               private(set) static var value24: Int?
                               private(set) static var value25: Int?
                               private(set) static var value26: Int?
                               private(set) static var value27: Int?
                               private(set) static var value28: Int?
                               private(set) static var value29: Int?
                               private(set) static var value30: Int?
                               private(set) static var value31: Int?
                               private(set) static var value32Parameter: Int?
                               private(set) static var value33: Int?
                               private(set) static var value34: Int?
                               private(set) static var value35: Int?
                               private(set) static var value36: Int?
                               private(set) static var value37: Int?
                               private(set) static var value38: Int?
                               private(set) static var value39: Int?
                               private(set) static var value40: Int?
                               private(set) static var value41: Int?
                               private(set) static var value42: Int?
                               private(set) static var value43Parameter: Int?
                               private(set) static var value44: Int?
                               private(set) static var value45: Int?
                               private(set) static var value46: Int?
                               private(set) static var value47: Int?
                               private(set) static var value48: Int?
                               private(set) static var value49: Int?
                               private(set) static var value51: Int?
                               private(set) static var value52: Int?
                               private(set) static var value53: Int?
                               private(set) static var value54: Int?
                               private(set) static var value55: Int?
                               private(set) static var value56: Int?
                               private(set) static var value57: Int?
                               private(set) static var value58: Int?
                               private(set) static var value59: Int?
                               private(set) static var value60: Int?
                               private(set) static var value61: Int?
                               private(set) static var value62: Int?
                               private(set) static var value63: Int?
                               private(set) static var value64: Int?
                               private(set) static var value65: Int?
                               private(set) static var value66: Int?
                               private(set) static var value67: Int?
                               private(set) static var value68: Int?
                               private(set) static var value69: Int?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.value2 = nil
                                   MockTest.value3 = nil
                                   MockTest.value4 = nil
                                   MockTest.value5 = nil
                                   MockTest.value6 = nil
                                   MockTest.value7 = nil
                                   MockTest.value8 = nil
                                   MockTest.value9 = nil
                                   MockTest.value10Parameter = nil
                                   MockTest.value11 = nil
                                   MockTest.value12 = nil
                                   MockTest.value13 = nil
                                   MockTest.value14 = nil
                                   MockTest.value15 = nil
                                   MockTest.value16 = nil
                                   MockTest.value17 = nil
                                   MockTest.value18 = nil
                                   MockTest.value19 = nil
                                   MockTest.value20 = nil
                                   MockTest.value21Parameter = nil
                                   MockTest.value22 = nil
                                   MockTest.value23 = nil
                                   MockTest.value24 = nil
                                   MockTest.value25 = nil
                                   MockTest.value26 = nil
                                   MockTest.value27 = nil
                                   MockTest.value28 = nil
                                   MockTest.value29 = nil
                                   MockTest.value30 = nil
                                   MockTest.value31 = nil
                                   MockTest.value32Parameter = nil
                                   MockTest.value33 = nil
                                   MockTest.value34 = nil
                                   MockTest.value35 = nil
                                   MockTest.value36 = nil
                                   MockTest.value37 = nil
                                   MockTest.value38 = nil
                                   MockTest.value39 = nil
                                   MockTest.value40 = nil
                                   MockTest.value41 = nil
                                   MockTest.value42 = nil
                                   MockTest.value43Parameter = nil
                                   MockTest.value44 = nil
                                   MockTest.value45 = nil
                                   MockTest.value46 = nil
                                   MockTest.value47 = nil
                                   MockTest.value48 = nil
                                   MockTest.value49 = nil
                                   MockTest.value51 = nil
                                   MockTest.value52 = nil
                                   MockTest.value53 = nil
                                   MockTest.value54 = nil
                                   MockTest.value55 = nil
                                   MockTest.value56 = nil
                                   MockTest.value57 = nil
                                   MockTest.value58 = nil
                                   MockTest.value59 = nil
                                   MockTest.value60 = nil
                                   MockTest.value61 = nil
                                   MockTest.value62 = nil
                                   MockTest.value63 = nil
                                   MockTest.value64 = nil
                                   MockTest.value65 = nil
                                   MockTest.value66 = nil
                                   MockTest.value67 = nil
                                   MockTest.value68 = nil
                                   MockTest.value69 = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo1() {
                                   calledStaticMethods.insert(.foo1Called)
                               }

                               static func foo2(_ value2: Int) {
                                   calledStaticMethods.insert(.foo2Value2Called)
                                   self.value2 = value2
                                   assignedStaticParameters.insert(.value2)
                               }

                               static func foo3(_ value3: Int) {
                                   calledStaticMethods.insert(.foo3Value3Called)
                                   self.value3 = value3
                                   assignedStaticParameters.insert(.value3)
                               }

                               static func foo4(_ value4: Int) {
                                   calledStaticMethods.insert(.foo4Value4Called)
                                   self.value4 = value4
                                   assignedStaticParameters.insert(.value4)
                               }

                               static func foo5(_ value5: Int) {
                                   calledStaticMethods.insert(.foo5Value5Called)
                                   self.value5 = value5
                                   assignedStaticParameters.insert(.value5)
                               }

                               static func foo6(_ value6: Int) {
                                   calledStaticMethods.insert(.foo6Value6Called)
                                   self.value6 = value6
                                   assignedStaticParameters.insert(.value6)
                               }

                               static func foo7(_ value7: Int) {
                                   calledStaticMethods.insert(.foo7Value7Called)
                                   self.value7 = value7
                                   assignedStaticParameters.insert(.value7)
                               }

                               static func foo8(_ value8: Int) {
                                   calledStaticMethods.insert(.foo8Value8Called)
                                   self.value8 = value8
                                   assignedStaticParameters.insert(.value8)
                               }

                               static func foo9(_ value9: Int) {
                                   calledStaticMethods.insert(.foo9Value9Called)
                                   self.value9 = value9
                                   assignedStaticParameters.insert(.value9)
                               }

                               static func foo10(_ value10: Int) {
                                   calledStaticMethods.insert(.foo10Value10Called)
                                   self.value10Parameter = value10
                                   assignedStaticParameters.insert(.value10Parameter)
                               }

                               static func foo11(_ value11: Int) {
                                   calledStaticMethods.insert(.foo11Value11Called)
                                   self.value11 = value11
                                   assignedStaticParameters.insert(.value11)
                               }

                               static func foo12(_ value12: Int) {
                                   calledStaticMethods.insert(.foo12Value12Called)
                                   self.value12 = value12
                                   assignedStaticParameters.insert(.value12)
                               }

                               static func foo13(_ value13: Int) {
                                   calledStaticMethods.insert(.foo13Value13Called)
                                   self.value13 = value13
                                   assignedStaticParameters.insert(.value13)
                               }

                               static func foo14(_ value14: Int) {
                                   calledStaticMethods.insert(.foo14Value14Called)
                                   self.value14 = value14
                                   assignedStaticParameters.insert(.value14)
                               }

                               static func foo15(_ value15: Int) {
                                   calledStaticMethods.insert(.foo15Value15Called)
                                   self.value15 = value15
                                   assignedStaticParameters.insert(.value15)
                               }

                               static func foo16(_ value16: Int) {
                                   calledStaticMethods.insert(.foo16Value16Called)
                                   self.value16 = value16
                                   assignedStaticParameters.insert(.value16)
                               }

                               static func foo17(_ value17: Int) {
                                   calledStaticMethods.insert(.foo17Value17Called)
                                   self.value17 = value17
                                   assignedStaticParameters.insert(.value17)
                               }

                               static func foo18(_ value18: Int) {
                                   calledStaticMethods.insert(.foo18Value18Called)
                                   self.value18 = value18
                                   assignedStaticParameters.insert(.value18)
                               }

                               static func foo19(_ value19: Int) {
                                   calledStaticMethods.insert(.foo19Value19Called)
                                   self.value19 = value19
                                   assignedStaticParameters.insert(.value19)
                               }

                               static func foo20(_ value20: Int) {
                                   calledStaticMethods.insert(.foo20Value20Called)
                                   self.value20 = value20
                                   assignedStaticParameters.insert(.value20)
                               }

                               static func foo21(_ value21: Int) {
                                   calledStaticMethods.insert(.foo21Value21Called)
                                   self.value21Parameter = value21
                                   assignedStaticParameters.insert(.value21Parameter)
                               }

                               static func foo22(_ value22: Int) {
                                   calledStaticMethods.insert(.foo22Value22Called)
                                   self.value22 = value22
                                   assignedStaticParameters.insert(.value22)
                               }

                               static func foo23(_ value23: Int) {
                                   calledStaticMethods.insert(.foo23Value23Called)
                                   self.value23 = value23
                                   assignedStaticParameters.insert(.value23)
                               }

                               static func foo24(_ value24: Int) {
                                   calledStaticMethods.insert(.foo24Value24Called)
                                   self.value24 = value24
                                   assignedStaticParameters.insert(.value24)
                               }

                               static func foo25(_ value25: Int) {
                                   calledStaticMethods.insert(.foo25Value25Called)
                                   self.value25 = value25
                                   assignedStaticParameters.insert(.value25)
                               }

                               static func foo26(_ value26: Int) {
                                   calledStaticMethods.insert(.foo26Value26Called)
                                   self.value26 = value26
                                   assignedStaticParameters.insert(.value26)
                               }

                               static func foo27(_ value27: Int) {
                                   calledStaticMethods.insert(.foo27Value27Called)
                                   self.value27 = value27
                                   assignedStaticParameters.insert(.value27)
                               }

                               static func foo28(_ value28: Int) {
                                   calledStaticMethods.insert(.foo28Value28Called)
                                   self.value28 = value28
                                   assignedStaticParameters.insert(.value28)
                               }

                               static func foo29(_ value29: Int) {
                                   calledStaticMethods.insert(.foo29Value29Called)
                                   self.value29 = value29
                                   assignedStaticParameters.insert(.value29)
                               }

                               static func foo30(_ value30: Int) {
                                   calledStaticMethods.insert(.foo30Value30Called)
                                   self.value30 = value30
                                   assignedStaticParameters.insert(.value30)
                               }

                               static func foo31(_ value31: Int) {
                                   calledStaticMethods.insert(.foo31Value31Called)
                                   self.value31 = value31
                                   assignedStaticParameters.insert(.value31)
                               }

                               static func foo32(_ value32: Int) {
                                   calledStaticMethods.insert(.foo32Value32Called)
                                   self.value32Parameter = value32
                                   assignedStaticParameters.insert(.value32Parameter)
                               }

                               static func foo33(_ value33: Int) {
                                   calledStaticMethods.insert(.foo33Value33Called)
                                   self.value33 = value33
                                   assignedStaticParameters.insert(.value33)
                               }

                               static func foo34(_ value34: Int) {
                                   calledStaticMethods.insert(.foo34Value34Called)
                                   self.value34 = value34
                                   assignedStaticParameters.insert(.value34)
                               }

                               static func foo35(_ value35: Int) {
                                   calledStaticMethods.insert(.foo35Value35Called)
                                   self.value35 = value35
                                   assignedStaticParameters.insert(.value35)
                               }

                               static func foo36(_ value36: Int) {
                                   calledStaticMethods.insert(.foo36Value36Called)
                                   self.value36 = value36
                                   assignedStaticParameters.insert(.value36)
                               }

                               static func foo37(_ value37: Int) {
                                   calledStaticMethods.insert(.foo37Value37Called)
                                   self.value37 = value37
                                   assignedStaticParameters.insert(.value37)
                               }

                               static func foo38(_ value38: Int) {
                                   calledStaticMethods.insert(.foo38Value38Called)
                                   self.value38 = value38
                                   assignedStaticParameters.insert(.value38)
                               }

                               static func foo39(_ value39: Int) {
                                   calledStaticMethods.insert(.foo39Value39Called)
                                   self.value39 = value39
                                   assignedStaticParameters.insert(.value39)
                               }

                               static func foo40(_ value40: Int) {
                                   calledStaticMethods.insert(.foo40Value40Called)
                                   self.value40 = value40
                                   assignedStaticParameters.insert(.value40)
                               }

                               static func foo41(_ value41: Int) {
                                   calledStaticMethods.insert(.foo41Value41Called)
                                   self.value41 = value41
                                   assignedStaticParameters.insert(.value41)
                               }

                               static func foo42(_ value42: Int) {
                                   calledStaticMethods.insert(.foo42Value42Called)
                                   self.value42 = value42
                                   assignedStaticParameters.insert(.value42)
                               }

                               static func foo43(_ value43: Int) {
                                   calledStaticMethods.insert(.foo43Value43Called)
                                   self.value43Parameter = value43
                                   assignedStaticParameters.insert(.value43Parameter)
                               }

                               static func foo44(_ value44: Int) {
                                   calledStaticMethods.insert(.foo44Value44Called)
                                   self.value44 = value44
                                   assignedStaticParameters.insert(.value44)
                               }

                               static func foo45(_ value45: Int) {
                                   calledStaticMethods.insert(.foo45Value45Called)
                                   self.value45 = value45
                                   assignedStaticParameters.insert(.value45)
                               }

                               static func foo46(_ value46: Int) {
                                   calledStaticMethods.insert(.foo46Value46Called)
                                   self.value46 = value46
                                   assignedStaticParameters.insert(.value46)
                               }

                               static func foo47(_ value47: Int) {
                                   calledStaticMethods.insert(.foo47Value47Called)
                                   self.value47 = value47
                                   assignedStaticParameters.insert(.value47)
                               }

                               static func foo48(_ value48: Int) {
                                   calledStaticMethods.insert(.foo48Value48Called)
                                   self.value48 = value48
                                   assignedStaticParameters.insert(.value48)
                               }

                               static func foo49(_ value49: Int) {
                                   calledStaticMethods.insert(.foo49Value49Called)
                                   self.value49 = value49
                                   assignedStaticParameters.insert(.value49)
                               }

                               static func foo50() {
                                   calledStaticMethods.insert(.foo50Called)
                               }

                               static func foo51(_ value51: Int) {
                                   calledStaticMethods.insert(.foo51Value51Called)
                                   self.value51 = value51
                                   assignedStaticParameters.insert(.value51)
                               }

                               static func foo52(_ value52: Int) {
                                   calledStaticMethods.insert(.foo52Value52Called)
                                   self.value52 = value52
                                   assignedStaticParameters.insert(.value52)
                               }

                               static func foo53(_ value53: Int) {
                                   calledStaticMethods.insert(.foo53Value53Called)
                                   self.value53 = value53
                                   assignedStaticParameters.insert(.value53)
                               }

                               static func foo54(_ value54: Int) {
                                   calledStaticMethods.insert(.foo54Value54Called)
                                   self.value54 = value54
                                   assignedStaticParameters.insert(.value54)
                               }

                               static func foo55(_ value55: Int) {
                                   calledStaticMethods.insert(.foo55Value55Called)
                                   self.value55 = value55
                                   assignedStaticParameters.insert(.value55)
                               }

                               static func foo56(_ value56: Int) {
                                   calledStaticMethods.insert(.foo56Value56Called)
                                   self.value56 = value56
                                   assignedStaticParameters.insert(.value56)
                               }

                               static func foo57(_ value57: Int) {
                                   calledStaticMethods.insert(.foo57Value57Called)
                                   self.value57 = value57
                                   assignedStaticParameters.insert(.value57)
                               }

                               static func foo58(_ value58: Int) {
                                   calledStaticMethods.insert(.foo58Value58Called)
                                   self.value58 = value58
                                   assignedStaticParameters.insert(.value58)
                               }

                               static func foo59(_ value59: Int) {
                                   calledStaticMethods.insert(.foo59Value59Called)
                                   self.value59 = value59
                                   assignedStaticParameters.insert(.value59)
                               }

                               static func foo60(_ value60: Int) {
                                   calledStaticMethods.insert(.foo60Value60Called)
                                   self.value60 = value60
                                   assignedStaticParameters.insert(.value60)
                               }

                               static func foo61(_ value61: Int) {
                                   calledStaticMethods.insert(.foo61Value61Called)
                                   self.value61 = value61
                                   assignedStaticParameters.insert(.value61)
                               }

                               static func foo62(_ value62: Int) {
                                   calledStaticMethods.insert(.foo62Value62Called)
                                   self.value62 = value62
                                   assignedStaticParameters.insert(.value62)
                               }

                               static func foo63(_ value63: Int) {
                                   calledStaticMethods.insert(.foo63Value63Called)
                                   self.value63 = value63
                                   assignedStaticParameters.insert(.value63)
                               }

                               static func foo64(_ value64: Int) {
                                   calledStaticMethods.insert(.foo64Value64Called)
                                   self.value64 = value64
                                   assignedStaticParameters.insert(.value64)
                               }

                               static func foo65(_ value65: Int) {
                                   calledStaticMethods.insert(.foo65Value65Called)
                                   self.value65 = value65
                                   assignedStaticParameters.insert(.value65)
                               }

                               static func foo66(_ value66: Int) {
                                   calledStaticMethods.insert(.foo66Value66Called)
                                   self.value66 = value66
                                   assignedStaticParameters.insert(.value66)
                               }

                               static func foo67(_ value67: Int) {
                                   calledStaticMethods.insert(.foo67Value67Called)
                                   self.value67 = value67
                                   assignedStaticParameters.insert(.value67)
                               }

                               static func foo68(_ value68: Int) {
                                   calledStaticMethods.insert(.foo68Value68Called)
                                   self.value68 = value68
                                   assignedStaticParameters.insert(.value68)
                               }

                               static func foo69(_ value69: Int) {
                                   calledStaticMethods.insert(.foo69Value69Called)
                                   self.value69 = value69
                                   assignedStaticParameters.insert(.value69)
                               }

                               static func foo70() {
                                   calledStaticMethods.insert(.foo70Called)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
                               var description: String {
                                   var value = "["
                                   var first = true
                                   func handleFirst() {
                                       if first {
                                           first = false
                                       } else {
                                           value += ", "
                                       }
                                   }

                                   if self.contains(.foo1Called) {
                                       handleFirst()
                                       value += ".foo1Called"
                                   }
                                   if self.contains(.foo2Value2Called) {
                                       handleFirst()
                                       value += ".foo2Value2Called"
                                   }
                                   if self.contains(.foo3Value3Called) {
                                       handleFirst()
                                       value += ".foo3Value3Called"
                                   }
                                   if self.contains(.foo4Value4Called) {
                                       handleFirst()
                                       value += ".foo4Value4Called"
                                   }
                                   if self.contains(.foo5Value5Called) {
                                       handleFirst()
                                       value += ".foo5Value5Called"
                                   }
                                   if self.contains(.foo6Value6Called) {
                                       handleFirst()
                                       value += ".foo6Value6Called"
                                   }
                                   if self.contains(.foo7Value7Called) {
                                       handleFirst()
                                       value += ".foo7Value7Called"
                                   }
                                   if self.contains(.foo8Value8Called) {
                                       handleFirst()
                                       value += ".foo8Value8Called"
                                   }
                                   if self.contains(.foo9Value9Called) {
                                       handleFirst()
                                       value += ".foo9Value9Called"
                                   }
                                   if self.contains(.foo10Value10Called) {
                                       handleFirst()
                                       value += ".foo10Value10Called"
                                   }
                                   if self.contains(.foo11Value11Called) {
                                       handleFirst()
                                       value += ".foo11Value11Called"
                                   }
                                   if self.contains(.foo12Value12Called) {
                                       handleFirst()
                                       value += ".foo12Value12Called"
                                   }
                                   if self.contains(.foo13Value13Called) {
                                       handleFirst()
                                       value += ".foo13Value13Called"
                                   }
                                   if self.contains(.foo14Value14Called) {
                                       handleFirst()
                                       value += ".foo14Value14Called"
                                   }
                                   if self.contains(.foo15Value15Called) {
                                       handleFirst()
                                       value += ".foo15Value15Called"
                                   }
                                   if self.contains(.foo16Value16Called) {
                                       handleFirst()
                                       value += ".foo16Value16Called"
                                   }
                                   if self.contains(.foo17Value17Called) {
                                       handleFirst()
                                       value += ".foo17Value17Called"
                                   }
                                   if self.contains(.foo18Value18Called) {
                                       handleFirst()
                                       value += ".foo18Value18Called"
                                   }
                                   if self.contains(.foo19Value19Called) {
                                       handleFirst()
                                       value += ".foo19Value19Called"
                                   }
                                   if self.contains(.foo20Value20Called) {
                                       handleFirst()
                                       value += ".foo20Value20Called"
                                   }
                                   if self.contains(.foo21Value21Called) {
                                       handleFirst()
                                       value += ".foo21Value21Called"
                                   }
                                   if self.contains(.foo22Value22Called) {
                                       handleFirst()
                                       value += ".foo22Value22Called"
                                   }
                                   if self.contains(.foo23Value23Called) {
                                       handleFirst()
                                       value += ".foo23Value23Called"
                                   }
                                   if self.contains(.foo24Value24Called) {
                                       handleFirst()
                                       value += ".foo24Value24Called"
                                   }
                                   if self.contains(.foo25Value25Called) {
                                       handleFirst()
                                       value += ".foo25Value25Called"
                                   }
                                   if self.contains(.foo26Value26Called) {
                                       handleFirst()
                                       value += ".foo26Value26Called"
                                   }
                                   if self.contains(.foo27Value27Called) {
                                       handleFirst()
                                       value += ".foo27Value27Called"
                                   }
                                   if self.contains(.foo28Value28Called) {
                                       handleFirst()
                                       value += ".foo28Value28Called"
                                   }
                                   if self.contains(.foo29Value29Called) {
                                       handleFirst()
                                       value += ".foo29Value29Called"
                                   }
                                   if self.contains(.foo30Value30Called) {
                                       handleFirst()
                                       value += ".foo30Value30Called"
                                   }
                                   if self.contains(.foo31Value31Called) {
                                       handleFirst()
                                       value += ".foo31Value31Called"
                                   }
                                   if self.contains(.foo32Value32Called) {
                                       handleFirst()
                                       value += ".foo32Value32Called"
                                   }
                                   if self.contains(.foo33Value33Called) {
                                       handleFirst()
                                       value += ".foo33Value33Called"
                                   }
                                   if self.contains(.foo34Value34Called) {
                                       handleFirst()
                                       value += ".foo34Value34Called"
                                   }
                                   if self.contains(.foo35Value35Called) {
                                       handleFirst()
                                       value += ".foo35Value35Called"
                                   }
                                   if self.contains(.foo36Value36Called) {
                                       handleFirst()
                                       value += ".foo36Value36Called"
                                   }
                                   if self.contains(.foo37Value37Called) {
                                       handleFirst()
                                       value += ".foo37Value37Called"
                                   }
                                   if self.contains(.foo38Value38Called) {
                                       handleFirst()
                                       value += ".foo38Value38Called"
                                   }
                                   if self.contains(.foo39Value39Called) {
                                       handleFirst()
                                       value += ".foo39Value39Called"
                                   }
                                   if self.contains(.foo40Value40Called) {
                                       handleFirst()
                                       value += ".foo40Value40Called"
                                   }
                                   if self.contains(.foo41Value41Called) {
                                       handleFirst()
                                       value += ".foo41Value41Called"
                                   }
                                   if self.contains(.foo42Value42Called) {
                                       handleFirst()
                                       value += ".foo42Value42Called"
                                   }
                                   if self.contains(.foo43Value43Called) {
                                       handleFirst()
                                       value += ".foo43Value43Called"
                                   }
                                   if self.contains(.foo44Value44Called) {
                                       handleFirst()
                                       value += ".foo44Value44Called"
                                   }
                                   if self.contains(.foo45Value45Called) {
                                       handleFirst()
                                       value += ".foo45Value45Called"
                                   }
                                   if self.contains(.foo46Value46Called) {
                                       handleFirst()
                                       value += ".foo46Value46Called"
                                   }
                                   if self.contains(.foo47Value47Called) {
                                       handleFirst()
                                       value += ".foo47Value47Called"
                                   }
                                   if self.contains(.foo48Value48Called) {
                                       handleFirst()
                                       value += ".foo48Value48Called"
                                   }
                                   if self.contains(.foo49Value49Called) {
                                       handleFirst()
                                       value += ".foo49Value49Called"
                                   }
                                   if self.contains(.foo50Called) {
                                       handleFirst()
                                       value += ".foo50Called"
                                   }
                                   if self.contains(.foo51Value51Called) {
                                       handleFirst()
                                       value += ".foo51Value51Called"
                                   }
                                   if self.contains(.foo52Value52Called) {
                                       handleFirst()
                                       value += ".foo52Value52Called"
                                   }
                                   if self.contains(.foo53Value53Called) {
                                       handleFirst()
                                       value += ".foo53Value53Called"
                                   }
                                   if self.contains(.foo54Value54Called) {
                                       handleFirst()
                                       value += ".foo54Value54Called"
                                   }
                                   if self.contains(.foo55Value55Called) {
                                       handleFirst()
                                       value += ".foo55Value55Called"
                                   }
                                   if self.contains(.foo56Value56Called) {
                                       handleFirst()
                                       value += ".foo56Value56Called"
                                   }
                                   if self.contains(.foo57Value57Called) {
                                       handleFirst()
                                       value += ".foo57Value57Called"
                                   }
                                   if self.contains(.foo58Value58Called) {
                                       handleFirst()
                                       value += ".foo58Value58Called"
                                   }
                                   if self.contains(.foo59Value59Called) {
                                       handleFirst()
                                       value += ".foo59Value59Called"
                                   }
                                   if self.contains(.foo60Value60Called) {
                                       handleFirst()
                                       value += ".foo60Value60Called"
                                   }
                                   if self.contains(.foo61Value61Called) {
                                       handleFirst()
                                       value += ".foo61Value61Called"
                                   }
                                   if self.contains(.foo62Value62Called) {
                                       handleFirst()
                                       value += ".foo62Value62Called"
                                   }
                                   if self.contains(.foo63Value63Called) {
                                       handleFirst()
                                       value += ".foo63Value63Called"
                                   }
                                   if self.contains(.foo64Value64Called) {
                                       handleFirst()
                                       value += ".foo64Value64Called"
                                   }
                                   if self.contains(.foo65Value65Called) {
                                       handleFirst()
                                       value += ".foo65Value65Called"
                                   }
                                   if self.contains(.foo66Value66Called) {
                                       handleFirst()
                                       value += ".foo66Value66Called"
                                   }
                                   if self.contains(.foo67Value67Called) {
                                       handleFirst()
                                       value += ".foo67Value67Called"
                                   }
                                   if self.contains(.foo68Value68Called) {
                                       handleFirst()
                                       value += ".foo68Value68Called"
                                   }
                                   if self.contains(.foo69Value69Called) {
                                       handleFirst()
                                       value += ".foo69Value69Called"
                                   }
                                   if self.contains(.foo70Called) {
                                       handleFirst()
                                       value += ".foo70Called"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
                               var description: String {
                                   var value = "["
                                   var first = true
                                   func handleFirst() {
                                       if first {
                                           first = false
                                       } else {
                                           value += ", "
                                       }
                                   }

                                   if self.contains(.value2) {
                                       handleFirst()
                                       value += ".value2"
                                   }
                                   if self.contains(.value3) {
                                       handleFirst()
                                       value += ".value3"
                                   }
                                   if self.contains(.value4) {
                                       handleFirst()
                                       value += ".value4"
                                   }
                                   if self.contains(.value5) {
                                       handleFirst()
                                       value += ".value5"
                                   }
                                   if self.contains(.value6) {
                                       handleFirst()
                                       value += ".value6"
                                   }
                                   if self.contains(.value7) {
                                       handleFirst()
                                       value += ".value7"
                                   }
                                   if self.contains(.value8) {
                                       handleFirst()
                                       value += ".value8"
                                   }
                                   if self.contains(.value9) {
                                       handleFirst()
                                       value += ".value9"
                                   }
                                   if self.contains(.value10Parameter) {
                                       handleFirst()
                                       value += ".value10Parameter"
                                   }
                                   if self.contains(.value11) {
                                       handleFirst()
                                       value += ".value11"
                                   }
                                   if self.contains(.value12) {
                                       handleFirst()
                                       value += ".value12"
                                   }
                                   if self.contains(.value13) {
                                       handleFirst()
                                       value += ".value13"
                                   }
                                   if self.contains(.value14) {
                                       handleFirst()
                                       value += ".value14"
                                   }
                                   if self.contains(.value15) {
                                       handleFirst()
                                       value += ".value15"
                                   }
                                   if self.contains(.value16) {
                                       handleFirst()
                                       value += ".value16"
                                   }
                                   if self.contains(.value17) {
                                       handleFirst()
                                       value += ".value17"
                                   }
                                   if self.contains(.value18) {
                                       handleFirst()
                                       value += ".value18"
                                   }
                                   if self.contains(.value19) {
                                       handleFirst()
                                       value += ".value19"
                                   }
                                   if self.contains(.value20) {
                                       handleFirst()
                                       value += ".value20"
                                   }
                                   if self.contains(.value21Parameter) {
                                       handleFirst()
                                       value += ".value21Parameter"
                                   }
                                   if self.contains(.value22) {
                                       handleFirst()
                                       value += ".value22"
                                   }
                                   if self.contains(.value23) {
                                       handleFirst()
                                       value += ".value23"
                                   }
                                   if self.contains(.value24) {
                                       handleFirst()
                                       value += ".value24"
                                   }
                                   if self.contains(.value25) {
                                       handleFirst()
                                       value += ".value25"
                                   }
                                   if self.contains(.value26) {
                                       handleFirst()
                                       value += ".value26"
                                   }
                                   if self.contains(.value27) {
                                       handleFirst()
                                       value += ".value27"
                                   }
                                   if self.contains(.value28) {
                                       handleFirst()
                                       value += ".value28"
                                   }
                                   if self.contains(.value29) {
                                       handleFirst()
                                       value += ".value29"
                                   }
                                   if self.contains(.value30) {
                                       handleFirst()
                                       value += ".value30"
                                   }
                                   if self.contains(.value31) {
                                       handleFirst()
                                       value += ".value31"
                                   }
                                   if self.contains(.value32Parameter) {
                                       handleFirst()
                                       value += ".value32Parameter"
                                   }
                                   if self.contains(.value33) {
                                       handleFirst()
                                       value += ".value33"
                                   }
                                   if self.contains(.value34) {
                                       handleFirst()
                                       value += ".value34"
                                   }
                                   if self.contains(.value35) {
                                       handleFirst()
                                       value += ".value35"
                                   }
                                   if self.contains(.value36) {
                                       handleFirst()
                                       value += ".value36"
                                   }
                                   if self.contains(.value37) {
                                       handleFirst()
                                       value += ".value37"
                                   }
                                   if self.contains(.value38) {
                                       handleFirst()
                                       value += ".value38"
                                   }
                                   if self.contains(.value39) {
                                       handleFirst()
                                       value += ".value39"
                                   }
                                   if self.contains(.value40) {
                                       handleFirst()
                                       value += ".value40"
                                   }
                                   if self.contains(.value41) {
                                       handleFirst()
                                       value += ".value41"
                                   }
                                   if self.contains(.value42) {
                                       handleFirst()
                                       value += ".value42"
                                   }
                                   if self.contains(.value43Parameter) {
                                       handleFirst()
                                       value += ".value43Parameter"
                                   }
                                   if self.contains(.value44) {
                                       handleFirst()
                                       value += ".value44"
                                   }
                                   if self.contains(.value45) {
                                       handleFirst()
                                       value += ".value45"
                                   }
                                   if self.contains(.value46) {
                                       handleFirst()
                                       value += ".value46"
                                   }
                                   if self.contains(.value47) {
                                       handleFirst()
                                       value += ".value47"
                                   }
                                   if self.contains(.value48) {
                                       handleFirst()
                                       value += ".value48"
                                   }
                                   if self.contains(.value49) {
                                       handleFirst()
                                       value += ".value49"
                                   }
                                   if self.contains(.value51) {
                                       handleFirst()
                                       value += ".value51"
                                   }
                                   if self.contains(.value52) {
                                       handleFirst()
                                       value += ".value52"
                                   }
                                   if self.contains(.value53) {
                                       handleFirst()
                                       value += ".value53"
                                   }
                                   if self.contains(.value54) {
                                       handleFirst()
                                       value += ".value54"
                                   }
                                   if self.contains(.value55) {
                                       handleFirst()
                                       value += ".value55"
                                   }
                                   if self.contains(.value56) {
                                       handleFirst()
                                       value += ".value56"
                                   }
                                   if self.contains(.value57) {
                                       handleFirst()
                                       value += ".value57"
                                   }
                                   if self.contains(.value58) {
                                       handleFirst()
                                       value += ".value58"
                                   }
                                   if self.contains(.value59) {
                                       handleFirst()
                                       value += ".value59"
                                   }
                                   if self.contains(.value60) {
                                       handleFirst()
                                       value += ".value60"
                                   }
                                   if self.contains(.value61) {
                                       handleFirst()
                                       value += ".value61"
                                   }
                                   if self.contains(.value62) {
                                       handleFirst()
                                       value += ".value62"
                                   }
                                   if self.contains(.value63) {
                                       handleFirst()
                                       value += ".value63"
                                   }
                                   if self.contains(.value64) {
                                       handleFirst()
                                       value += ".value64"
                                   }
                                   if self.contains(.value65) {
                                       handleFirst()
                                       value += ".value65"
                                   }
                                   if self.contains(.value66) {
                                       handleFirst()
                                       value += ".value66"
                                   }
                                   if self.contains(.value67) {
                                       handleFirst()
                                       value += ".value67"
                                   }
                                   if self.contains(.value68) {
                                       handleFirst()
                                       value += ".value68"
                                   }
                                   if self.contains(.value69) {
                                       handleFirst()
                                       value += ".value69"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        //printFirstDifference(code, expectedCode)  //Uncomment if needed. Too slow for regular execution
    }
    
}
//swiftlint:enable function_body_length file_length
