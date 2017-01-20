//
//  Weapon.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class WeaponTests: XCTestCase {
    
    func testExecuteDamagesChosenTarget() {
        let testObject = Weapon(damage: 3)
        let mockDamageable = DamageBar(max: 4)
        
        testObject.execute(targetStrategy: MockTargetStrategy(damageable: mockDamageable))
        
        XCTAssertEqual(mockDamageable.current, 1)
    }
    
    func testExecuteRefreshesAndDoesNotDamageWhenResourceCannotSpend() {
        let mockResource = MockEmptyResource()
        let testObject = Weapon(damage: 3, resource: mockResource)
        let mockDamageable = DamageBar(max: 4)
        
        testObject.execute(targetStrategy: MockTargetStrategy(damageable: mockDamageable))
        
        XCTAssertEqual(mockResource.refreshCounter, 1)
        XCTAssertEqual(mockDamageable.current, 4)
    }
    
    func testExecuteSpendsOneResourceIfPossible() {
        let mockResource = MockFreeResource()
        let testObject = Weapon(damage: 3, resource: mockResource)
        let mockDamageable = DamageBar(max: 4)
        
        testObject.execute(targetStrategy: MockTargetStrategy(damageable: mockDamageable))
        
        XCTAssertEqual(mockResource.spending, [1])
    }
    
    func testWhenAccuracyIsLowDamageIsHitOrMiss() {
        let testObject = Weapon(damage: 3, accuracy: 50)
        let mockDamageable = DamageBar(max: 10000)
        let strategy = MockTargetStrategy(damageable: mockDamageable)
        var missCount = 0
        var hitCount = 0
        
        for _ in 0...100 {
            let old = mockDamageable.current
            testObject.execute(targetStrategy: strategy)
            if mockDamageable.current < old {
                hitCount += 1
            } else {
                missCount += 1
            }
        }
        
        XCTAssertGreaterThan(hitCount, 20)
        XCTAssertGreaterThan(missCount, 20)
    }
    
    func testRapidFireHitsMultipleTimesAndSpendsMultipleAmmo() {
        let testObject = Weapon(damage: 2, ammo: 4, rapidFire: 3)
        let mockDamageable = MockDamageable()
        
        testObject.execute(targetStrategy: MockTargetStrategy(damageable: mockDamageable))
        
        XCTAssertEqual(mockDamageable.damageTaken, 6)
        XCTAssertEqual(mockDamageable.callCount, 3)
        XCTAssertEqual((testObject.resource as? BasicResource)?.current, 1)
    }
    
    func testRapidFireSpendsAllAmmoAndHitsThatManyTimesIfNotEnough() {
        let testObject = Weapon(damage: 2, ammo: 3, rapidFire: 4)
        let mockDamageable = MockDamageable()
        
        testObject.execute(targetStrategy: MockTargetStrategy(damageable: mockDamageable))
        
        XCTAssertEqual((testObject.resource as? BasicResource)?.current, 0)
        XCTAssertEqual(mockDamageable.damageTaken, 6)
        XCTAssertEqual(mockDamageable.callCount, 3)
    }
}

class MockTargetStrategy: TargetStrategy {
    
    let damageable: Damageable?
    
    init(damageable: Damageable? = nil) {
        self.damageable = damageable
    }
    
    func chooseDamageable() -> Damageable? {
        return damageable
    }
}

class MockEmptyResource: Resource {
    var refreshCounter = 0
    
    func canSpend(amount: Int) -> Bool {
        return false
    }
    
    func refresh() {
        refreshCounter += 1
    }
    
    func spend(amount: Int) {
        
    }
}

class MockFreeResource: FreeResource {
    var spending: [Int] = []
    
    override func spend(amount: Int) {
        spending.append(amount)
    }
}

class MockDamageable: Damageable {
    
    var callCount = 0
    var damageTaken = 0
    var canDamage = true
    
    func damage(damage: Damage) {
        callCount += 1
        damageTaken += damage.amount
    }
}
