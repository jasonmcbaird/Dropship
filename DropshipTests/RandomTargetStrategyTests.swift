//
//  RandomTargetStrategyTests.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class RandomTargetStrategyTests: XCTestCase {

    func testReturnsOneTargetFromAnEnemySquad() {
        let squad = Squad(readyables: [])
        let enemy = MockReadyableDamageable()
        let enemySquad = Squad(readyables: [enemy])
        squad.relationships.append(Relationship.enemy(enemySquad))
        let testObject = RandomTargetStrategy(squad: squad)
        
        testObject.chooseDamageable()?.damage(amount: 3)
        
        XCTAssertEqual(enemy.damageTotal, 3)
    }
    
    func testReturnsNilWhenNoTargets() {
        let squad = Squad(readyables: [])
        let enemySquad = Squad(readyables: [])
        squad.relationships.append(Relationship.enemy(enemySquad))
        let testObject = RandomTargetStrategy(squad: squad)
        
        XCTAssertNil(testObject.chooseDamageable())
    }
    
    func testReturnsAllTargetsFromEnemySquadsEventuallyAndNeverATargetFromAnAlliedSquad() {
        let squad = Squad(readyables: [])
        let enemyOne = MockReadyableDamageable()
        let enemyTwo = MockReadyableDamageable()
        let enemyThree = MockReadyableDamageable()
        let enemyFour = MockReadyableDamageable()
        let enemyFive = MockReadyableDamageable()
        let enemySquad = Squad(readyables: [enemyOne, enemyTwo, enemyThree])
        let enemySquadTwo = Squad(readyables: [enemyThree, enemyFour, enemyFive])
        let allyOne = MockReadyableDamageable()
        let allyTwo = MockReadyableDamageable()
        let allySquad = Squad(readyables: [allyOne, allyTwo])
        squad.relationships.append(Relationship.enemy(enemySquad))
        squad.relationships.append(Relationship.enemy(enemySquadTwo))
        squad.relationships.append(Relationship.ally(allySquad))
        let testObject = RandomTargetStrategy(squad: squad)
        for _ in 0...100 {
            testObject.chooseDamageable()?.damage(amount: 1)
        }
        XCTAssertGreaterThan(enemyOne.damageTotal, 2)
        XCTAssertGreaterThan(enemyOne.damageTotal, 2)
        XCTAssertGreaterThan(enemyOne.damageTotal, 2)
        XCTAssertGreaterThan(enemyOne.damageTotal, 2)
        XCTAssertGreaterThan(enemyOne.damageTotal, 2)
        XCTAssertEqual(allyOne.damageTotal, 0)
        XCTAssertEqual(allyTwo.damageTotal, 0)
    }
}

class MockReadyableDamageable: Readyable, Damageable {
    
    var ready = true
    var damageTotal = 0
    var canDamage = true
    
    func startTurn() {
        
    }
    
    func damage(damage: Damage) {
        damageTotal += damage.amount
    }
    
    func readyUp() {
        
    }
    
}
