//
//  File.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class FireTests: XCTestCase {
    
    func testExecute() {
        let testObject = Fire(damageAmount: 3)
        let mockDamageable = DamageBar(max: 4)
        
        testObject.execute(targetStrategy: MockTargetStrategy(damageable: mockDamageable))
        
        XCTAssertEqual(mockDamageable.current, 1)
    }
}

class MockTargetStrategy: TargetStrategy {
    
    let damageable: Damageable
    
    init(damageable: Damageable) {
        self.damageable = damageable
    }
    
    func chooseDamageable() -> Damageable {
        return damageable
    }
    
}
