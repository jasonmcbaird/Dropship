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
    
    func testOneVsOneCombat() {
        var jasonWins = 0
        var codyWins = 0
        for _ in 1...100 {
            let pistol = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let jason = Creature(name: "Jason", maxHealth: 5, abilities: [pistol])
            let pistol2 = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let cody = Creature(name: "Cody", maxHealth: 5, abilities: [pistol2])
            let combat = Initiative(squads: [Squad(readyables: [jason]), Squad(readyables: [cody])])
            jason.targetStrategy = RandomTargetStrategy(damageables: [cody])
            cody.targetStrategy = RandomTargetStrategy(damageables: [jason])
            combat.playCombat()
            
            if(!jason.dead) {
                XCTAssert(cody.dead)
                jasonWins += 1
            }
            if(!cody.dead) {
                XCTAssert(jason.dead)
                codyWins += 1
            }
        }
        
        XCTAssertGreaterThan(jasonWins, 20)
        XCTAssertGreaterThan(codyWins, 20)
        XCTAssertEqual(jasonWins + codyWins, 100)
    }
    
}
