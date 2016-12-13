//
//  Armor.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Armor: Damageable {
    
    var strength: Int
    var attributes: [String : Int] = [:]
    
    init(strength: Int) {
        self.strength = strength
    }
    
    func damage(damage: Damage) {
        damage.amount -= strength
    }
}
