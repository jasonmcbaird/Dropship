//
//  RandomizerTests.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class RandomizerTests: XCTestCase {

    func testRollsAllValuesEventuallyAndNothingElse() {
        var rollSequence: [Int] = []
        for _ in 0...100 {
            rollSequence.append(Randomizer.rollRange(5, 10))
        }
        for i in 5...10 {
            XCTAssertTrue(rollSequence.contains(i))
        }
        for roll in rollSequence {
            XCTAssertGreaterThanOrEqual(roll, 5)
            XCTAssertLessThanOrEqual(roll, 10)
        }
    }
}
