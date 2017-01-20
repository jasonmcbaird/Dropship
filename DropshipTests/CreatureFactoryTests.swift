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

    func testCreatedMarineHasHealthAndHasWeapon() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "Marine", weaponType: "Assault Rifle")
        
        guard let creature = result else {
            XCTFail("Couldn't create a marine")
            return
        }
        XCTAssertEqual(creature.health, 15)
        guard creature.abilities.count > 0,
            let weapon = creature.abilities[0] as? Weapon else {
            XCTFail("Created marine doesn't have a weapon")
            return
        }
        XCTAssertLessThan(weapon.accuracy, 85)
    }
    
    func testCreatedCommandoHasHealthAndShields() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "Commando", weaponType: "Assault Rifle")
        
        guard let creature = result else {
            XCTFail("Couldn't create a commando")
            return
        }
        XCTAssertGreaterThan(creature.health, 15)
        XCTAssert(creature.bars.contains(where: { bar in bar.name == "Shields" }))
    }
    
    func testUnknownTypeReturnsNil() {
        let testObject = CreatureFactory()
        
        let result = testObject.create(type: "junk")
        
        XCTAssertNil(result)
    }
}
