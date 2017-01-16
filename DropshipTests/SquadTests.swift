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
    
    func testStartNextActivatesNextUnactivated() {
        jason.ready = false
        
        testObject.startNext()
        
        XCTAssertEqual(jason.activationCount, 0)
        XCTAssertEqual(cody.activationCount, 1)
        XCTAssertEqual(cheyenne.activationCount, 0)
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
    
    func testGetEnemiesReturnsAllSquadsInEnemyRelationships() {
        let enemySquad = Squad(readyables: [])
        let allySquad = Squad(readyables: [])
        testObject.relationships.append(Relationship.enemy(enemySquad))
        testObject.relationships.append(Relationship.ally(allySquad))
        
        XCTAssertEqual(testObject.enemySquads.count, 1)
        XCTAssert(testObject.enemySquads[0] === enemySquad)
    }
    
}

class MockReadyable: Readyable {
    
    var activationCount: Int = 0
    var ready: Bool = true
    var readyCount: Int = 0
    
    func startTurn() {
        activationCount += 1
    }
    
    func readyUp() {
        readyCount += 1
    }
}
