//
//  FreeResourceTests.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class FreeResourceTests: XCTestCase {
    
    var testObject: Resource!
    
    override func setUp() {
        super.setUp()
        testObject = FreeResource()
    }
    
    func testCanSpendAnyAmount() {
        testObject.spend(amount: 1000)
        
        XCTAssertTrue(testObject.canSpend(amount: 1000))
    }
    
}
