//
//  Weapon.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Weapon: Executable {
    
    var resource: Resource
    var damage: Int
    var accuracy: Int
    var rapidFire: Int
    
    convenience init(damage: Int, rapidFire: Int = 1, accuracy: Int = 100) {
        self.init(damage: damage, resource: FreeResource(), rapidFire: rapidFire, accuracy: accuracy)
    }
    
    convenience init(damage: Int, battery: Int, rechargeAmount: Int, rapidFire: Int = 1, accuracy: Int = 100) {
        let resource = Battery(max: battery, rechargeAmount: rechargeAmount)
        self.init(damage: damage, resource: resource, rapidFire: rapidFire, accuracy: accuracy)
    }
    
    convenience init(damage: Int, ammo: Int, rapidFire: Int = 1, accuracy: Int = 100) {
        let resource = BasicResource(max: ammo)
        self.init(damage: damage, resource: resource, rapidFire: rapidFire, accuracy: accuracy)
    }
    
    init(damage: Int, resource: Resource, rapidFire: Int = 1, accuracy: Int = 100) {
        self.damage = damage
        self.resource = resource
        self.accuracy = accuracy
        self.rapidFire = rapidFire
    }
    
    func canExecute(targetStrategy: TargetStrategy) -> Bool {
        return targetStrategy.chooseDamageable() != nil
    }
    
    func execute(targetStrategy: TargetStrategy) {
        if(resource.canSpend(amount: 1)) {
            for i in 1...rapidFire {
                if(resource.canSpend(amount: 1)) {
                    resource.spend(amount: 1)
                    let roll = Randomizer.rollDie(100)
                    if(accuracy >= roll) {
                        targetStrategy.chooseDamageable()?.damage(amount: damage)
                    }
                }
            }
        } else {
            resource.refresh()
        }
    }
    
}
