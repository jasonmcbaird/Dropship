//
//  ResourceTests.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class BasicResourceTests: XCTestCase {
    
    var testObject: Resource!
    
    override func setUp() {
        super.setUp()
        testObject = BasicResource(max: 5)
    }
    
    func testCanSpendExactlyAsMuchAsHave() {
        XCTAssertTrue(testObject.canSpend(amount: 5))
        XCTAssertFalse(testObject.canSpend(amount: 6))
    }
    
    func testSpendReducesAmountCanSpend() {
        testObject.spend(amount: 1)
        
        XCTAssertFalse(testObject.canSpend(amount: 5))
    }
    
    func testAfterSpendThenRefreshCanSpendExactlyAsMuchAsStartedWith() {
        testObject.spend(amount: 3)
        testObject.refresh()
        
        XCTAssertTrue(testObject.canSpend(amount: 5))
        XCTAssertFalse(testObject.canSpend(amount: 6))
    }
    
}
