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
        let testObject = Weapon(damage: 3, resource: FreeResource())
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
}

class MockTargetStrategy: TargetStrategy {
    let damageable: Damageable
    
    init(damageable: Damageable) {
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
