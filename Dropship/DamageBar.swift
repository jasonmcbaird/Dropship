//
//  DamageBar.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class DamageBar: Damageable, Bar {
	
    var name: String
    var current: Int {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Current Changed"), object: self)
        }
    }
    var max: Int {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Current Changed"), object: self)
        }
    }
    var canDamage: Bool {
        return !empty
    }
    
    init(name: String = "Damage Bar", max: Int) {
        self.name = name
		current = max
		self.max = max
	}
	
	func damage(amount: Int, type: DamageType) {
		damage(damage: Damage(amount: amount, type: type))
	}
	
	func damage(damage: Damage) {
		current -= damage.amount
		if(current < 0) {
			let result = -current
			current = 0
			damage.amount = result
		} else {
			damage.amount = 0
		}
	}
}
