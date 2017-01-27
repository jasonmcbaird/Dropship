//
//  CombatBuilder.swift
//  Dropship
//
//  Created by dev1 on 1/4/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class CombatFactory {
    
    func create(type: CombatType, delayer: Delayer = DelayTimer(loopTime: 1)) -> Initiative? {
        switch(type) {
        case .gulch:
            guard let creatureFactory = CreatureFactory() else {
                return nil
            }
            
            var red: [Creature] = []
            if let commando = creatureFactory.create(type: "Commando") {
                red.append(commando)
            }
            for _ in 1...3 {
                if let trooper = creatureFactory.create(type: "Trooper") {
                    red.append(trooper)
                }
            }
            
            var blue: [Creature] = []
            if let sniper = creatureFactory.create(type: "Sniper") {
                blue.append(sniper)
            }
            if let heavy = creatureFactory.create(type: "Heavy") {
                blue.append(heavy)
            }
            if let assault = creatureFactory.create(type: "Assault") {
                blue.append(assault)
            }
            if let assault = creatureFactory.create(type: "Assault") {
                blue.append(assault)
            }
            
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
