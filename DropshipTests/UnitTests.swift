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
		let testObject = Unit(name: "Jason", maxHealth: 5)
		
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.health, 2)
	}
    
    func testDamageDoesntReduceHealthBelowZero() {
		let testObject = Unit(name: "Jason", maxHealth: 5)
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.health, 0)
    }
    
    func testDamageReducesCustomDamageBarsBeforeDefaultHealth() {
        let cover = DamageBar(max: 5)
        let testObject = Unit(name: "Jason", maxHealth: 5, damageables: [cover])
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(cover.current, 0)
		XCTAssertEqual(testObject.health, 1)
    }
	
	func testActivationRespondersstartTurn() {
		let mockActivatable = MockReadyable()
		let testObject = Unit(name: "Jason", maxHealth: 5, activatables: [mockActivatable])
		
		testObject.startTurn()
		
		XCTAssertEqual(mockActivatable.activationCount, 1)
	}
    
    func testHealthBelowZeroMeansDead() {
        let testObject = Unit(name: "Jason", maxHealth: 5)
        
        testObject.damage(amount: 3)
        testObject.damage(amount: 3)
        
        XCTAssertTrue(testObject.dead)
    }
    
    func testActivateMakesUnready() {
        let testObject = Unit(name: "Jason", maxHealth: 5)
        
        testObject.startTurn()
        
        XCTAssertFalse(testObject.ready)
    }
    
    func testReadyUpMakesReady() {
        let testObject = Unit(name: "Jason", maxHealth: 5)
        
        testObject.ready = false
        testObject.readyUp()
        
        XCTAssertTrue(testObject.ready)
    }
}
