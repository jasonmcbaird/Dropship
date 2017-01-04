//
//  RandomExecutionStrategyTests.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class RandomExecutionStrategyTests: XCTestCase {
    
    func testChoosesAllValuesEventually() {
        var abilities: [MockAbility] = []
        for _ in 0...4 {
            abilities.append(MockAbility())
        }
        let testObject = RandomExecutionStrategy()
        for _ in 0...100 {
            testObject.chooseAbility(abilities: abilities)!.execute(targetStrategy: MockTargetStrategy())
        }
        for i in 0...4 {
            XCTAssertGreaterThan(abilities[i].executionCount, 1)
        }
    }
}
