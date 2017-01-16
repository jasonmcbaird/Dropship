//
//  CombatBuilder.swift
//  Dropship
//
//  Created by dev1 on 1/4/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class CombatFactory {
    
    func createCombat(type: CombatType, delayer: Delayer = DelayTimer(loopTime: 1)) -> Initiative {
        switch(type) {
        case .gulch:
            var red: [Creature] = []
            let rifle = Weapon(damage: 4, ammo: 1, accuracy: 80)
            let shields = Shields(maxShields: 4, rechargeDelay: 2, rechargeAmount: 2)
            red.append(Creature(name: "Jason", maxHealth: 15, damageables: [shields], activatables: [shields], abilities: [rifle]))
            let pistol = Weapon(damage: 3, ammo: 3, accuracy: 70)
            red.append(Creature(name: "Cody", maxHealth: 15, abilities: [pistol]))
            let pistol2 = Weapon(damage: 3, ammo: 3, accuracy: 70)
            red.append(Creature(name: "Cheyenne", maxHealth: 15, abilities: [pistol2]))
            var blue: [Creature] = []
            let smg = Weapon(damage: 4, ammo: 4, accuracy: 60)
            blue.append(Creature(name: "Jody", maxHealth: 15, abilities: [smg]))
            let smg2 = Weapon(damage: 4, ammo: 4, accuracy: 60)
            blue.append(Creature(name: "Kevin", maxHealth: 15, abilities: [smg2]))
            let smg3 = Weapon(damage: 4, ammo: 4, accuracy: 60)
            blue.append(Creature(name: "Tux", maxHealth: 15, abilities: [smg3]))
            let targetBlueStrategy = RandomTargetStrategy(damageables: blue)
            let targetRedStrategy = RandomTargetStrategy(damageables: red)
            for creature in red {
                creature.targetStrategy = targetBlueStrategy
            }
            for creature in blue {
                creature.targetStrategy = targetRedStrategy
            }
            let redSquad = Squad(readyables: red)
            let blueSquad = Squad(readyables: blue)
            return Initiative(squads: [redSquad, blueSquad], delayer: delayer)
        }
    }
}
