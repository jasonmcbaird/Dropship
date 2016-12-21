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
    
    convenience init(damage: Int) {
        self.init(damage: damage, resource: FreeResource())
    }
    
    convenience init(damage: Int, battery: Int, rechargeAmount: Int) {
        let resource = Battery(max: battery, rechargeAmount: rechargeAmount)
        self.init(damage: damage, resource: resource)
    }
    
    convenience init(damage: Int, ammo: Int) {
        let resource = BasicResource(max: ammo)
        self.init(damage: damage, resource: resource)
    }
    
    init(damage: Int, resource: Resource) {
        self.damage = damage
        self.resource = resource
    }
    
    func canExecute(targetStrategy: TargetStrategy) -> Bool {
        return targetStrategy.chooseDamageable() != nil
    }
    
    func execute(targetStrategy: TargetStrategy) {
        if(resource.canSpend(amount: 1)) {
            resource.spend(amount: 1)
            targetStrategy.chooseDamageable()?.damage(amount: damage)
        } else {
            resource.refresh()
        }
    }
    
}
