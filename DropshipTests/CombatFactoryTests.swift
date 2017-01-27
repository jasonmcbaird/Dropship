//
//  CombatFactoryTests.swift
//  Dropship
//
//  Created by dev1 on 1/4/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class CombatFactoryTests: XCTestCase {
    
    func testGulchFirstCreatureHasA4DamageWeapon() {
        let testObject = CombatFactory()
        guard let combat = testObject.create(type: .gulch) else {
            XCTFail("Failed to make a Gulch")
            return
        }
        
        XCTAssertEqual(((combat.squads[0].readyables[0] as! Creature).abilities[0] as! Weapon).damage, 3)
    }
    
    func testGulchIs4v4() {
        let testObject = CombatFactory()
        guard let combat = testObject.create(type: .gulch) else {
            XCTFail("Failed to make a Gulch")
            return
        }
        
        XCTAssertEqual(combat.squads[0].readyables.count, 4)
        XCTAssertEqual(combat.squads[1].readyables.count, 4)
    }
    
    func testGulchBothWinSometimes() {
        let testObject = CombatFactory()
        var redWins = 0
        var blueWins = 0
        for _ in 1...100 {
            guard let combat = testObject.create(type: .gulch, delayer: FakeDelayer()) else {
                XCTFail("Failed to make a Gulch")
                return
            }
            
            combat.playCombat()
            if combat.squads[0].ready {
                redWins += 1
            }
            if combat.squads[1].ready {
                blueWins += 1
            }
        }
        print("Red won \(redWins) times")
        XCTAssertGreaterThan(redWins, 10)
        print("Blue won \(blueWins) times")
        XCTAssertGreaterThan(blueWins, 10)
        XCTAssertEqual(redWins + blueWins, 100)
    }
    
}
