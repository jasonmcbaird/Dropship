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
    
    convenience init(damage: Int, accuracy: Int = 100) {
        self.init(damage: damage, resource: FreeResource(), accuracy: accuracy)
    }
    
    convenience init(damage: Int, battery: Int, rechargeAmount: Int, accuracy: Int = 100) {
        let resource = Battery(max: battery, rechargeAmount: rechargeAmount)
        self.init(damage: damage, resource: resource, accuracy: accuracy)
    }
    
    convenience init(damage: Int, ammo: Int, accuracy: Int = 100) {
        let resource = BasicResource(max: ammo)
        self.init(damage: damage, resource: resource, accuracy: accuracy)
    }
    
    init(damage: Int, resource: Resource, accuracy: Int = 100) {
        self.damage = damage
        self.resource = resource
        self.accuracy = accuracy
    }
    
    func canExecute(targetStrategy: TargetStrategy) -> Bool {
        return targetStrategy.chooseDamageable() != nil
    }
    
    func execute(targetStrategy: TargetStrategy) {
        if(resource.canSpend(amount: 1)) {
            resource.spend(amount: 1)
            let roll = Randomizer.rollDie(100)
            if(accuracy >= roll) {
                targetStrategy.chooseDamageable()?.damage(amount: damage)
            }
        } else {
            resource.refresh()
        }
    }
    
}
