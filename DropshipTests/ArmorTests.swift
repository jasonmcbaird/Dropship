//
//  Armor.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class ArmorTests: XCTestCase {
    
    func testDamageReducesDamage() {
        let damage = Damage(amount: 3)
        let testObject = Armor(amount: 1)
        
        testObject.damage(damage: damage)
        
        XCTAssertEqual(damage.amount, 2)
    }
}
