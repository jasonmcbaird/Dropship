//
//  DamageBarTests.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class DamageBarTests: XCTestCase {

    func testDamageReducesCurrent() {
        let testObject = DamageBar(max: 10)
        
        testObject.damage(amount: 5)
        
        XCTAssertEqual(testObject.current, 5)
    }
    
    func testDamageCannotReduceCurrentBelowZero() {
        let testObject = DamageBar(max: 10)
        
        testObject.damage(amount: 11)
        
        XCTAssertEqual(testObject.current, 0)
    }
    
    func testDamageBeyondZeroHealthStaysInDamageObject() {
        let damage = Damage(amount: 11)
        let testObject = DamageBar(max: 10)
        
        testObject.damage(damage: damage)
        
        XCTAssertEqual(damage.amount, 1)
    }
    
}
