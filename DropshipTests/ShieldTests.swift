//
//  ShieldTests.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class ShieldTests: XCTestCase {
    
    var testObject: Shields!
    
    override func setUp() {
        testObject = Shields(maxShields: 10, rechargeDelay: 2, rechargeAmount: 3)
    }
    
    func testDamageReducesShields() {
        testObject.damage(amount: 3)
        
        XCTAssertEqual(testObject.shields, 7)
    }
    
    func testFirstActivateDoesntRestoreShields() {
        testObject.damage(amount: 3)
        testObject.activate()
        
        XCTAssertEqual(testObject.shields, 7)
    }
    
    func testThirdActivateRestoresShields() {
        testObject.damage(amount: 3)
        testObject.activate()
        testObject.activate()
        testObject.activate()
        
        XCTAssertEqual(testObject.shields, 10)
    }
    
}
