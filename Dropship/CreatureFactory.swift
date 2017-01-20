//
//  CreatureBuilder.swift
//  Dropship
//
//  Created by dev1 on 1/20/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class CreatureFactory {
    
    func create(type: String, weaponType: String? = nil) -> Creature? {
        var health = 15
        var abilities: [Ability] = []
        if let weaponType = weaponType, let weapon = WeaponFactory()?.create(type: weaponType) {
            abilities.append(weapon)
        }
        var damageables: [Damageable] = []
        if type == "Commando" {
            health = 21
            damageables.append(Shields(maxShields: 9, rechargeDelay: 3, rechargeAmount: 3))
            return Creature(name: type, maxHealth: health, damageables: damageables, abilities: abilities)
        } else if type == "Marine" {
            return Creature(name: type, maxHealth: health, damageables: damageables, abilities: abilities)
        }
        return nil
    }
    
}
