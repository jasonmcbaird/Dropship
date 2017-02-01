//
//  CreatureFactoryTests.swift
//  Dropship
//
//  Created by dev1 on 1/20/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class CreatureFactoryTests: XCTestCase {

    func testCreatedTrooperHas15HealthAndHasLowAccuracyWeapon() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "Trooper")
        
        guard let creature = result else {
            XCTFail("Couldn't create a trooper")
            return
        }
        XCTAssertEqual(creature.health, 15)
        guard creature.abilities.count > 0,
            let weapon = creature.abilities[0] as? Weapon else {
            XCTFail("Created trooper doesn't have a weapon")
            return
        }
        XCTAssertLessThan(weapon.accuracy, 85)
    }
    
    func testCreatedCommandoHasMoreHealthAndShieldsAndLowAccuracyWeapon() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "Commando")
        
        guard let creature = result else {
            XCTFail("Couldn't create a commando")
            return
        }
        XCTAssertGreaterThan(creature.health, 15)
        XCTAssert(creature.bars.contains(where: { bar in bar.name == "Shields" }))
        guard creature.abilities.count > 0,
            let weapon = creature.abilities[0] as? Weapon else {
                XCTFail("Created marine doesn't have a weapon")
                return
        }
        XCTAssertLessThan(weapon.accuracy, 85)
    }
    
    func testCreatedHeavyHas15HealthAndArmorAndARapidFireWeapon() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "Heavy")
        result?.damage(amount: 1)
        
        guard let creature = result else {
            XCTFail("Couldn't create a heavy")
            return
        }
        XCTAssertEqual(creature.health, 15)
        guard creature.abilities.count > 0,
            let weapon = creature.abilities[0] as? Weapon else {
                XCTFail("Created Heavy doesn't have a weapon")
                return
        }
        XCTAssertGreaterThan(weapon.rapidFire, 2)
    }
    
    func testUnknownTypeReturnsNil() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "junk")
        
        XCTAssertNotNil(testObject)
        XCTAssertNil(result)
    }
}
