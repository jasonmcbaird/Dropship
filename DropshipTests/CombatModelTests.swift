//
//  CombatSystemTest.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class CombatSystemTests: XCTestCase {
    
    func testOneVsOneEndsWhenOneDies() {
        let pistol = Weapon(damage: 3, ammo: 3, accuracy: 60)
        let jason = Unit(name: "Jason", maxHealth: 15, executables: [pistol])
        let pistol2 = Weapon(damage: 6, ammo: 1, accuracy: 85)
        let cody = Unit(name: "Cody", maxHealth: 15, executables: [pistol2])
        let initiative = Initiative(squads: [Squad(readyables: [cody]), Squad(readyables: [jason])])
        cody.targetStrategy = MockTargetStrategy(damageable: jason)
        jason.targetStrategy = MockTargetStrategy(damageable: cody)
        
        initiative.playCombat()
        
        XCTAssertTrue(jason.dead || cody.dead)
    }
    
    func testOneVsOneBothDieSometimes() {
        var jasonWins = 0
        var codyWins = 0
        for _ in 1...100 {
            let rifle = Weapon(damage: 4, ammo: 1, accuracy: 80)
            let jason = Unit(name: "Jason", maxHealth: 15, executables: [rifle])
            let pistol = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let cody = Unit(name: "Cody", maxHealth: 15, executables: [pistol])
            let initiative = Initiative(squads: [Squad(readyables: [cody]), Squad(readyables: [jason])])
            cody.targetStrategy = MockTargetStrategy(damageable: jason)
            jason.targetStrategy = MockTargetStrategy(damageable: cody)
            
            initiative.playCombat()
            if(!jason.dead) {
                jasonWins += 1
            }
            if(!cody.dead) {
                codyWins += 1
            }
        }
        print("Jason won \(jasonWins) times")
        XCTAssertGreaterThan(jasonWins, 10)
        print("Cody won \(codyWins) times")
        XCTAssertGreaterThan(codyWins, 10)
    }
    
    func testSquadBothDieSometimes() {
        var jasonWins = 0
        var cheyenneWins = 0
        for _ in 1...100 {
            let rifle = Weapon(damage: 4, ammo: 1, accuracy: 80)
            let jason = Unit(name: "Jason", maxHealth: 15, executables: [rifle])
            let pistol = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let cody = Unit(name: "Cody", maxHealth: 15, executables: [pistol])
            let pistol2 = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let cheyenne = Unit(name: "Cheyenne", maxHealth: 15, executables: [pistol2])
            let pistol3 = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let kevin = Unit(name: "Kevin", maxHealth: 15, executables: [pistol3])
            let redSquad = Squad(readyables: [cody, jason])
            let blueSquad = Squad(readyables: [cheyenne, kevin])
            let initiative = Initiative(squads: [redSquad, blueSquad])
            cody.targetStrategy = RandomTargetStrategy(squad: redSquad)
            jason.targetStrategy = RandomTargetStrategy(squad: redSquad)
            cheyenne.targetStrategy = RandomTargetStrategy(squad: blueSquad)
            kevin.targetStrategy = RandomTargetStrategy(squad: blueSquad)
            redSquad.relationships.append(Relationship.enemy(blueSquad))
            blueSquad.relationships.append(Relationship.enemy(redSquad))
            
            initiative.playCombat()
            if(redSquad.ready) {
                jasonWins += 1
            }
            if(blueSquad.ready) {
                cheyenneWins += 1
            }
        }
        print("Jason won \(jasonWins) times")
        XCTAssertGreaterThan(jasonWins, 10)
        print("Cheyenne won \(cheyenneWins) times")
        XCTAssertGreaterThan(cheyenneWins, 10)
        XCTAssertEqual(jasonWins + cheyenneWins, 100)
    }
    
    func testQuickSetupBothDieSometimes() {
        var jasonWins = 0
        var cheyenneWins = 0
        for _ in 1...100 {
            let rifle = Weapon(damage: 4, ammo: 1, accuracy: 80)
            let jason = Unit(name: "Jason", maxHealth: 15, executables: [rifle])
            let pistol = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let cody = Unit(name: "Cody", maxHealth: 15, executables: [pistol])
            let pistol2 = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let cheyenne = Unit(name: "Cheyenne", maxHealth: 15, executables: [pistol2])
            let pistol3 = Weapon(damage: 3, ammo: 3, accuracy: 65)
            let kevin = Unit(name: "Kevin", maxHealth: 15, executables: [pistol3])
            let testObject = CombatModel(readyableSets: [[jason, cody], [cheyenne, kevin]])
            
            testObject.playCombat()
            if(testObject.initiative.squads[0].ready) {
                jasonWins += 1
            }
            if(testObject.initiative.squads[1].ready) {
                cheyenneWins += 1
            }
        }
        print("Jason won \(jasonWins) times")
        XCTAssertGreaterThan(jasonWins, 10)
        print("Cheyenne won \(cheyenneWins) times")
        XCTAssertGreaterThan(cheyenneWins, 10)
        XCTAssertEqual(jasonWins + cheyenneWins, 100)
    }
}
