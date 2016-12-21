//
//  DamageBar.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class DamageBar: Damageable, Bar {
	
	var current: Int
	var max: Int
    
	init(max: Int) {
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
