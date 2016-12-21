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
        
        testObject.startTurn()
        testObject.readyUp()
        
        XCTAssertTrue(testObject.ready)
    }
    
    func testWhenStartTurnThenExecutesOneExecutable() {
        let executable1 = MockExecutable()
        let executable2 = MockExecutable()
        let testObject = Unit(name: "Jason", maxHealth: 5, executables: [executable1, executable2])
        
        testObject.startTurn()
        
        XCTAssertEqual(executable1.executionCount + executable2.executionCount, 1)
    }
    
    func testExecutionChoiceIsDeterminedByExecutableStrategy() {
        for _ in 0...10 {
            let executable1 = MockExecutable()
            let executable2 = MockExecutable()
            let testObject = Unit(name: "Jason", maxHealth: 5, executables: [executable1, executable2], executionStrategy: MockExecutionStrategy())
            
            testObject.startTurn()
            
            XCTAssertEqual(executable1.executionCount, 1)
            XCTAssertEqual(executable2.executionCount, 0)
        }
    }
    
    func testIfCannotExecuteFirstExecutableThenExecutesNext() {
        let executable1 = MockExecutable(canExecute: false)
        let executable2 = MockExecutable()
        let testObject = Unit(name: "Jason", maxHealth: 5, executables: [executable1, executable2], executionStrategy: MockExecutionStrategy())
        
        testObject.startTurn()
        
        XCTAssertEqual(executable1.executionCount, 0)
        XCTAssertEqual(executable2.executionCount, 1)
    }
}

class MockExecutable: Executable {
    
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
    
    func chooseExecutable(executables: [Executable]) -> Executable? {
        if(executables.count > 0) {
            return executables[0]
        } else {
            return nil
        }
    }
}
