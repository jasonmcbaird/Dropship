//
//  Fire.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Fire: Ability {
    
    var damageAmount: Int
    
    init(damageAmount: Int) {
        self.damageAmount = damageAmount
    }
    
    func execute(targetStrategy: TargetStrategy) {
        targetStrategy.chooseDamageable().damage(amount: damageAmount)
    }
    
}
