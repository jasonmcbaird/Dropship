//
//  CombatSystemTests.swift
//  Dropship
//
//  Created by dev1 on 12/13/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import XCTest
@testable import Dropship

class CombatSystemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testOneVsOneCombat() {
        var jasonWins = 0
        var codyWins = 0
        for _ in 1...100 {
            let jason = Unit(name: "Jason", health: 5, damageResponders: [], activationResponders: [])
            let cody = Unit(name: "Cody", health: 5, damageResponders: [], activationResponders: [])
            let combat = Combat(activatables: [jason, cody])
            combat.playCombat()
            
            if(!jason.dead) {
                jasonWins += 1
            }
            if(!cody.dead) {
                codyWins += 1
            }
        }
        
        XCTAssertGreaterThan(jasonWins, 20)
        XCTAssertGreaterThan(codyWins, 20)
        XCTAssertEqual(jasonWins + codyWins, 100)
    }
    
}
