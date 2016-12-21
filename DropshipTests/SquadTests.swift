//
//  SquadTests.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import XCTest
@testable import Dropship

class SquadTests: XCTestCase {
    
    var jason: MockReadyable!
    var cody: MockReadyable!
    var cheyenne: MockReadyable!
    var testObject: Squad!
    
    override func setUp() {
        super.setUp()
        jason = MockReadyable()
        cody = MockReadyable()
        cheyenne = MockReadyable()
        testObject = Squad(readyables: [jason, cody, cheyenne])
    }
    
    func testActivateActivatesAllActivatables() {
        testObject.activate()
        
        XCTAssertEqual(jason.activationCount, 1)
        XCTAssertEqual(cody.activationCount, 1)
        XCTAssertEqual(cheyenne.activationCount, 1)
    }
    
    func testNotReadyIfNoActivatableIsReady() {
        jason.ready = false
        cody.ready = false
        cheyenne.ready = false
        
        XCTAssertFalse(testObject.ready)
    }
    
    func testReadyUpReadiesAllActivatables() {
        jason.ready = false
        cody.ready = false
        cheyenne.ready = false
        
        testObject.readyUp()
        
        XCTAssertEqual(jason.readyCount, 1)
        XCTAssertEqual(cody.readyCount, 1)
        XCTAssertEqual(cheyenne.readyCount, 1)
    }
    
}

class MockReadyable: Readyable {
    
    var activationCount: Int = 0
    var ready: Bool = true
    var readyCount: Int = 0
    
    func activate() {
        activationCount += 1
    }
    
    func readyUp() {
        readyCount += 1
    }
}
