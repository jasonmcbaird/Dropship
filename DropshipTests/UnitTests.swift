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
		let testObject = Unit(name: "Jason", health: 5)
		
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.health, 2)
	}
    
    func testDamageDoesntReduceHealthBelowZero() {
		let testObject = Unit(name: "Jason", health: 5)
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.health, 0)
    }
    
    func testDamageReducesCustomDamageBarsBeforeDefaultHealth() {
        let cover = DamageBar(max: 5)
        let testObject = Unit(name: "Jason", health: 5, damageResponders: [cover])
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(cover.current, 0)
		XCTAssertEqual(testObject.health, 1)
    }
	
	func testActivationRespondersActivate() {
		let mockActivatable = MockReadyable()
		let testObject = Unit(name: "Jason", health: 5, damageResponders: [], activationResponders: [mockActivatable])
		
		testObject.activate()
		
		XCTAssertEqual(mockActivatable.activationCount, 1)
	}
    
    func testHealthBelowZeroMeansDead() {
        let testObject = Unit(name: "Jason", health: 5)
        
        testObject.damage(amount: 3)
        testObject.damage(amount: 3)
        
        XCTAssertTrue(testObject.dead)
    }
    
    func testActivateMakesUnready() {
        let testObject = Unit(name: "Jason", health: 5)
        
        testObject.activate()
        
        XCTAssertFalse(testObject.ready)
    }
    
    func testReadyUpMakesReady() {
        let testObject = Unit(name: "Jason", health: 5)
        
        testObject.ready = false
        testObject.readyUp()
        
        XCTAssertTrue(testObject.ready)
    }
    
}

