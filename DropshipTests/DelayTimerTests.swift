//
//  DelayTimerTests.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class DelayTimerTests: XCTestCase {
    
    var testObject: DelayTimer!
    
    override func setUp() {
        testObject = DelayTimer(loopTime: Int(0))
    }
    
    func testWhenClosureReturnsTrueThenDelaysOnceThenExecutesOnce() {
        var callCount = 0
        let expect = expectation(description: "Wait for timer")
        testObject.executeAfterDelay() {
            callCount += 1
            return false
        }
        XCTAssertEqual(callCount, 0)
        DelayTimer(loopTime: 0).executeAfterDelay() {
            XCTAssertEqual(callCount, 1)
            expect.fulfill()
            return false
        }
        waitForExpectations(timeout: 1, handler: { error in XCTAssertNil(error) })
    }
    
    func testRepeatsUntilClosureReturnsTrue() {
        var callCount = 0
        let expect = expectation(description: "Wait for timer")
        testObject.executeAfterDelay() {
            callCount += 1
            if callCount > 2 {
                return false
            } else {
                return true
            }
        }
        XCTAssertEqual(callCount, 0)
        DelayTimer(loopTime: 1).executeAfterDelay() {
            XCTAssertEqual(callCount, 3)
            expect.fulfill()
            return false
        }
        waitForExpectations(timeout: 1.1, handler: { error in XCTAssertNil(error) })
    }
}
