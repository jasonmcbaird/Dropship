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
    
    func testAssaultRifleIsRapidFire() {
        let testObject = WeaponFactory()
        
        let assaultRifle = testObject.getWeapon(type: "Assault Rifle")
        
        XCTAssertNotNil(assaultRifle)
        XCTAssertGreaterThan(assaultRifle.rapidFire, 1)
    }

}
