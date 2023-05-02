//
//  NameTrackerTests.swift
//  MockerTests
//
//  Created by Greg on 9/7/18.
//

import XCTest
@testable import Mocker

class NameTrackerTests: XCTestCase {

    var tracker: NameTracker!
    
    override func setUp() {
        super.setUp()
        tracker = NameTracker()
    }

    func testEmptyTracker() {
        
        XCTAssertNil(tracker.uniqueName(for: "A", identifiedBy: "B"))
        XCTAssertNil(tracker.uniqueName(for: "C", identifiedBy: "D"))
    }

    func testDistinctNamesAndTypes() {
        
        tracker.addTracking(of: "A", identifiedBy: "TypeA")
        tracker.addTracking(of: "B", identifiedBy: "TypeB")
        tracker.addTracking(of: "C", identifiedBy: "TypeC")

        XCTAssertEqual(tracker.uniqueName(for: "A", identifiedBy: "TypeA"), "A")
        XCTAssertEqual(tracker.uniqueName(for: "B", identifiedBy: "TypeB"), "B")
        XCTAssertEqual(tracker.uniqueName(for: "C", identifiedBy: "TypeC"), "C")
        XCTAssertNil(tracker.uniqueName(for: "D", identifiedBy: "TypeD"))
    }

    func testDuplicateNamesForTypes() {
        
        tracker.addTracking(of: "A", identifiedBy: "TypeA")
        tracker.addTracking(of: "A", identifiedBy: "TypeA1")
        tracker.addTracking(of: "B", identifiedBy: "TypeB")
        tracker.addTracking(of: "C", identifiedBy: "TypeC")
        tracker.addTracking(of: "C", identifiedBy: "TypeC1")
        tracker.addTracking(of: "C", identifiedBy: "TypeC2")

        XCTAssertEqual(tracker.uniqueName(for: "A", identifiedBy: "TypeA"), "A")
        XCTAssertEqual(tracker.uniqueName(for: "A", identifiedBy: "TypeA1"), "A1")
        XCTAssertEqual(tracker.uniqueName(for: "B", identifiedBy: "TypeB"), "B")
        XCTAssertEqual(tracker.uniqueName(for: "C", identifiedBy: "TypeC"), "C")
        XCTAssertEqual(tracker.uniqueName(for: "C", identifiedBy: "TypeC1"), "C1")
        XCTAssertEqual(tracker.uniqueName(for: "C", identifiedBy: "TypeC2"), "C2")
        XCTAssertNil(tracker.uniqueName(for: "D", identifiedBy: "TypeD"))
    }

}
