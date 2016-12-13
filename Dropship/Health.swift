//
//  Health.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Health: Damageable {
	
	var health: Int {
		return healthBar.current
	}
	var healthMax: Int {
		return healthBar.max
	}
    var dead: Bool {
        return healthBar.empty
    }
	
	private let healthBar: DamageBar
	
	init(maxHealth: Int) {
		self.healthBar = DamageBar(max: maxHealth)
	}
	
	func damage(damage: Damage) {
		healthBar.damage(damage: damage)
	}
}
