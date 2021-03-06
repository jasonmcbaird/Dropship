//
//  BatteryResourceTests.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class BatteryResourceTests: XCTestCase {

    var testObject: BatteryResource!
    
    override func setUp() {
        super.setUp()
        testObject = BatteryResource(max: 5, rechargeAmount: 2)
    }
    
    func testCanSpendExactlyAsMuchAsHave() {
        XCTAssertTrue(testObject.canSpend(amount: 5))
        XCTAssertFalse(testObject.canSpend(amount: 6))
    }
    
    func testSpendReducesAmountCanSpend() {
        testObject.spend(amount: 1)
        
        XCTAssertFalse(testObject.canSpend(amount: 5))
    }
    
    func testRefreshDoesNotChangeAmount() {
        testObject.spend(amount: 2)
        testObject.refresh()
        
        XCTAssertTrue(testObject.canSpend(amount: 3))
        XCTAssertFalse(testObject.canSpend(amount: 4))
    }
    
    func testActivateRechargesTwo() {
        testObject.spend(amount: 3)
        testObject.startTurn()
        
        XCTAssertTrue(testObject.canSpend(amount: 4))
        XCTAssertFalse(testObject.canSpend(amount: 5))
    }
    
    func testActivateCannotRechargeAboveMax() {
        testObject.spend(amount: 1)
        testObject.startTurn()
        
        XCTAssertTrue(testObject.canSpend(amount: 5))
        XCTAssertFalse(testObject.canSpend(amount: 6))
    }

}
