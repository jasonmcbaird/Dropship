//
//  DropshipTests.swift
//  DropshipTests
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import XCTest
@testable import Dropship

class CreatureTests: XCTestCase {
	
	func testDamageReducesHealth() {
		let testObject = Creature(name: "Jason", maxHealth: 5)
		
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.health, 2)
	}
    
    func testDamageDoesntReduceHealthBelowZero() {
		let testObject = Creature(name: "Jason", maxHealth: 5)
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(testObject.health, 0)
    }
    
    func testDamageReducesCustomDamageBarsBeforeDefaultHealth() {
        let cover = DamageBar(max: 5)
        let testObject = Creature(name: "Jason", maxHealth: 5, damageables: [cover])
		
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		testObject.damage(amount: 3)
		
		XCTAssertEqual(cover.current, 0)
		XCTAssertEqual(testObject.health, 1)
    }
	
	func testActivationRespondersstartTurn() {
		let mockActivatable = MockReadyable()
		let testObject = Creature(name: "Jason", maxHealth: 5, activatables: [mockActivatable])
		
		testObject.startTurn()
		
		XCTAssertEqual(mockActivatable.activationCount, 1)
	}
    
    func testHealthBelowZeroMeansDead() {
        let testObject = Creature(name: "Jason", maxHealth: 5)
        
        testObject.damage(amount: 3)
        testObject.damage(amount: 3)
        
        XCTAssertTrue(testObject.dead)
    }
    
    func testActivateMakesUnready() {
        let testObject = Creature(name: "Jason", maxHealth: 5)
        
        testObject.startTurn()
        
        XCTAssertFalse(testObject.ready)
    }
    
    func testReadyUpMakesReady() {
        let testObject = Creature(name: "Jason", maxHealth: 5)
        
        testObject.startTurn()
        testObject.readyUp()
        
        XCTAssertTrue(testObject.ready)
    }
    
    func testWhenStartTurnThenExecutesOneAbility() {
        let ability1 = MockAbility()
        let ability2 = MockAbility()
        let testObject = Creature(name: "Jason", maxHealth: 5, abilities: [ability1, ability2])
        
        testObject.startTurn()
        
        XCTAssertEqual(ability1.executionCount + ability2.executionCount, 1)
    }
    
    func testExecutionChoiceIsDeterminedByAbilityStrategy() {
        for _ in 0...10 {
            let ability1 = MockAbility()
            let ability2 = MockAbility()
            let testObject = Creature(name: "Jason", maxHealth: 5, abilities: [ability1, ability2], executionStrategy: MockExecutionStrategy())
            
            testObject.startTurn()
            
            XCTAssertEqual(ability1.executionCount, 1)
            XCTAssertEqual(ability2.executionCount, 0)
        }
    }
    
    func testIfCannotExecuteFirstAbilityThenExecutesNext() {
        let ability1 = MockAbility(canExecute: false)
        let ability2 = MockAbility()
        let testObject = Creature(name: "Jason", maxHealth: 5, abilities: [ability1, ability2], executionStrategy: MockExecutionStrategy())
        
        testObject.startTurn()
        
        XCTAssertEqual(ability1.executionCount, 0)
        XCTAssertEqual(ability2.executionCount, 1)
    }
    
    func testBarsIncludesHealthShieldsAndAmmo() {
        let testObject = Creature(name: "Jason", maxHealth: 5, damageables: [Shields(maxShields: 5, rechargeDelay: 3, rechargeAmount: 1)], abilities: [Weapon(damage: 3, ammo: 3)], executionStrategy: MockExecutionStrategy())
        XCTAssertEqual(testObject.bars.count, 3)
        var hasHealth = false
        var hasShields = false
        var hasAmmo = false
        for bar in testObject.bars {
            switch(bar.name) {
            case "Health":
                hasHealth = true
            case "Shields":
                hasShields = true
            case "Ammo":
                hasAmmo = true
            default:
                break
            }
        }
        XCTAssertTrue(hasHealth)
        XCTAssertTrue(hasShields)
        XCTAssertTrue(hasAmmo)
    }
}

class MockAbility: Ability {
    
    var executionCount = 0
    let canExecute: Bool
    
    init(canExecute: Bool = true) {
        self.canExecute = canExecute
    }
    
    func canExecute(targetStrategy: TargetStrategy) -> Bool {
        return canExecute
    }
    
    func execute(targetStrategy: TargetStrategy) {
        executionCount += 1
    }
}

class MockExecutionStrategy: ExecutionStrategy {
    
    func chooseAbility(abilities: [Ability]) -> Ability? {
        if abilities.count > 0 {
            return abilities[0]
        } else {
            return nil
        }
    }
}
