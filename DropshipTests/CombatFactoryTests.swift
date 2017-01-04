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
        let initiative = testObject.createCombat(type: .gulch)
        
        XCTAssertEqual(((initiative.squads[0].readyables[0] as! Creature).abilities[0] as! Weapon).damage, 4)
    }
    
    func testGulchBothWinSometimes() {
        var redWins = 0
        var blueWins = 0
        for _ in 1...100 {
            let initiative = CombatFactory().createCombat(type: .gulch)
            
            initiative.playCombat()
            if(initiative.squads[0].ready) {
                redWins += 1
            }
            if(initiative.squads[1].ready) {
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
