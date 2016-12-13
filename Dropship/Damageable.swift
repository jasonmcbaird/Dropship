//
//  Damageable.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol Damageable {
	
	func damage(damage: Damage)
	func damage(amount: Int)
	func damage(amount: Int, type: DamageType)
	
}

extension Damageable {
	
	func damage(amount: Int) {
		damage(damage: Damage(amount: amount))
	}
	
	func damage(amount: Int, type: DamageType) {
		damage(damage: Damage(amount: amount, type: type))
	}
}
