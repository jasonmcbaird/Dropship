//
//  CombatTests.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class CombatTests: XCTestCase {
    
    var testObject: Combat!
    var mock: MockUnreadySquad!
    var mock2: MockUnreadySquad!
    
    override func setUp() {
        super.setUp()
        mock = MockUnreadySquad(activationsAvailable: 3)
        mock2 = MockUnreadySquad(activationsAvailable: 6)
        testObject = Combat(squads: [mock, mock2], delayer: FakeDelayer())
    }
    
    func testPlayCombatLoopsAndResetsActivatablesUntilNoneAreReady() {
        testObject.playCombat()
        
        XCTAssertFalse(mock.ready)
        XCTAssertEqual(mock.resetCount, 4)
        XCTAssertFalse(mock2.ready)
        XCTAssertEqual(mock2.resetCount, 4)
    }
}

class MockUnreadySquad: Squad {
    
    var activationCount: Int {
        return (readyables[0] as! MockUnreadyReadyable).activationCount
    }
    var resetCount: Int {
        return (readyables[0] as! MockUnreadyReadyable).resetCount
    }
    
    convenience init(activationsAvailable: Int) {
        self.init(readyables: [MockUnreadyReadyable(activationsAvailable: activationsAvailable)])
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
        if activationCount >= activationsAvailable {
            resetCount += 1
            ready = false
        }
    }
    
    func readyUp() {
        if resetCount <= 3 {
            ready = true
        }
    }
    
}

class FakeDelayer: Delayer {
    
    func executeAfterDelay(closure: @escaping () -> (Bool)) {
        if closure() {
            executeAfterDelay(closure: closure)
        }
    }
    
}
