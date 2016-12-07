//
//  Health.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Health: Damageable {
	
	public var attributes: [String: Int] {
		var result = healthBar.attributes
		if(result["health"]! < 0) {
			result.updateValue(1, forKey: "dead")
		} else {
			result.updateValue(0, forKey: "dead")
		}
		return result
	}
	
	private let healthBar: DamageBar
	
	init(maxHealth: Int) {
		self.healthBar = DamageBar(name: "health", max: maxHealth)
	}
	
	public func damage(damage: Damage) {
		healthBar.damage(damage: damage)
	}
}
