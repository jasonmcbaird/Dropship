//
//  WeaponFactoryTests.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//
import Foundation
import XCTest
@testable import Dropship

class WeaponFactoryTests: XCTestCase {
    
    func testAssaultRifleIsRapidFireAndInaccurate() {
        guard let testObject = WeaponFactory() else {
            XCTFail("Cannot instantiate weapon factory")
            return
        }
        guard let assaultRifle = testObject.getWeapon(type: "Assault Rifle") else {
            XCTFail("Cannot instantiate assault rifle")
            return
        }
        XCTAssertGreaterThan(assaultRifle.rapidFire, 1)
        XCTAssertLessThan(assaultRifle.accuracy, 85)
    }
}
