//
//  InitiativeRandomTargetStrategy.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class RandomTargetStrategy: TargetStrategy {

    private var damageables: [Damageable]
    
    convenience init(squad: Squad) {
        var possibleTargets: [Damageable] = []
        for enemySquad in squad.enemySquads {
            for enemy in enemySquad.readyables {
                if let enemy = enemy as? Damageable {
                    possibleTargets.append(enemy)
                }
            }
        }
        self.init(damageables: possibleTargets)
    }
    
    init(damageables: [Damageable]) {
        self.damageables = damageables
    }
    
    func chooseDamageable() -> Damageable? {
        let possibleTargets = damageables.filter({ $0.canDamage })
        if possibleTargets.count > 0 {
            return possibleTargets[Randomizer.rollRange(0, possibleTargets.count - 1)]
        } else {
            return nil
        }
    }
}
