//
//  InitiativeRandomTargetStrategy.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class RandomTargetStrategy: TargetStrategy {
    
    private var squad: Squad
    
    init(squad: Squad) {
        self.squad = squad
    }
    
    func chooseDamageable() -> Damageable? {
        var possibleTargets: [Damageable] = []
        for enemySquad in squad.enemySquads {
            for enemy in enemySquad.readyables {
                if let enemy = enemy as? Damageable {
                    possibleTargets.append(enemy)
                }
            }
        }
        if(possibleTargets.count > 0) {
            return possibleTargets[Randomizer.rollRange(0, possibleTargets.count - 1)]
        } else {
            return nil
        }
    }
    
}
