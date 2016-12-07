//
//  DropshipTests.swift
//  DropshipTests
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import XCTest
@testable import Dropship

class UnitTests: XCTestCase {
	
	func testDamageReducesHealth() {
		let testObject = Unit(name: "Jason", health: 5, damageResponders: [], activationResponders: [])
		
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.attributes["health"], 2)
	}
    
    func testDamageDoesntReduceHealthBelowZero() {
		let testObject = Unit(name: "Jason", health: 5, damageResponders: [], activationResponders: [])
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.attributes["health"], 0)
    }
    
    func testDamageReducesCustomDamageBarsBeforeDefaultHealth() {
		let testObject = Unit(name: "Jason", health: 5, damageResponders: [DamageBar(name: "cover", max: 5)], activationResponders: [])
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.attributes["cover"], 0)
		XCTAssertEqual(testObject.attributes["health"], 1)
    }
	
	func testActivationRespondersActivate() {
		let mock = MockActivatable()
		let testObject = Unit(name: "Jason", health: 5, damageResponders: [], activationResponders: [mock])
		
		testObject.activate()
		
		XCTAssertTrue(mock.activated)
	}
    
}

class MockActivatable: Activatable {
	
	var activated: Bool = false
	
	func activate() {
		activated = true
	}
}
