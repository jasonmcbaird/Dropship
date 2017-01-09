//
//  RandomTargetStrategy.swift
//  Dropship
//
//  Created by dev1 on 1/4/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class RandomTargetStrategy: TargetStrategy {
    
    var damageables: [Damageable]
    
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
