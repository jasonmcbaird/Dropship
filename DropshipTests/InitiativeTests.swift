//
//  InitiativeTests.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class InitiativeTests: XCTestCase {
    
    var testObject: Initiative!
    var mock: MockUnreadyReadyable!
    var mock2: MockUnreadyReadyable!
    
    override func setUp() {
        super.setUp()
        mock = MockUnreadyReadyable(activationsAvailable: 3)
        mock2 = MockUnreadyReadyable(activationsAvailable: 6)
        testObject = Initiative(squads: [mock, mock2])
    }
    
    func testPlayRoundActivatesActivatablesUntilNoneAreReady() {
        testObject.playRound()
        
        XCTAssertEqual(mock.activationCount, 3)
        XCTAssertEqual(mock2.activationCount, 6)
    }
    
    func testPlayInitiativeLoopsAndResetsActivatablesUntilNoneAreReady() {
        testObject.playCombat()
        
        XCTAssertFalse(mock.ready)
        XCTAssertEqual(mock.resetCount, 4)
        XCTAssertFalse(mock2.ready)
        XCTAssertEqual(mock2.resetCount, 4)
    }
}

class MockUnreadyReadyable: Readyable {
    
    var activationsAvailable: Int
    var activationCount = 0
    
    init(activationsAvailable: Int) {
        self.activationsAvailable = activationsAvailable
    }
    
    var ready = true
    var resetCount = 0
    
    func startTurn() {
        activationCount += 1
        if(activationCount >= activationsAvailable) {
            resetCount += 1
            ready = false
        }
    }
    
    func readyUp() {
        if(resetCount <= 3) {
            ready = true
        }
    }
    
}