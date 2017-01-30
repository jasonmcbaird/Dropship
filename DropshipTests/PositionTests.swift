//
//  PositionTests.swift
//  Dropship
//
//  Created by dev1 on 1/30/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class PositionTests: XCTestCase {
    
    func testGetDistance() {
        let testObject = Position(x: 3, y: 3)
        let otherPosition = Position(x: 5, y: 5)
        let diagonalPosition = Position(x: -1, y: 5)
        
        XCTAssertEqual(testObject.distanceTo(position: otherPosition), 4)
        XCTAssertEqual(testObject.distanceTo(position: diagonalPosition), 6)
    }
    
}
