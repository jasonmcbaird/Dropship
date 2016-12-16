//
//  Armor.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Armor: Damageable {
    
    var amount: Int
    
    init(amount: Int) {
        self.amount = amount
    }
    
    func damage(damage: Damage) {
        damage.amount -= amount
    }
}
