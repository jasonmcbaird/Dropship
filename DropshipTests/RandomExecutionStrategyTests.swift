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
        var executables: [MockExecutable] = []
        for _ in 0...4 {
            executables.append(MockExecutable())
        }
        let testObject = RandomExecutionStrategy()
        for _ in 0...100 {
            testObject.chooseExecutable(executables: executables)!.execute(targetStrategy: MockTargetStrategy())
        }
        for i in 0...4 {
            XCTAssertGreaterThan(executables[i].executionCount, 1)
        }
    }
}
