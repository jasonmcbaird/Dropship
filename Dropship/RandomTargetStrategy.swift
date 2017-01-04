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
        if damageables.count > 0 {
            return damageables[Randomizer.rollRange(0, damageables.count - 1)]
        } else {
            return nil
        }
    }
}
