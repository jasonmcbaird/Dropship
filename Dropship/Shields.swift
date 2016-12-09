//
//  Shields.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Shields: Damageable, Activatable {
	
	var attributes: [String: Int] {
		return shieldBar.attributes
	}
	
	private var shieldBar: DamageBar
	private var rechargeDelay: Int
	private var rechargeAmount: Int
	private var rechargeCounter: Int
	
	init(maxShields: Int, rechargeDelay: Int, rechargeAmount: Int) {
		self.rechargeDelay = rechargeDelay
		self.rechargeAmount = rechargeAmount
		self.rechargeCounter = 0
		self.shieldBar = DamageBar(name: "shields", max: maxShields)
	}
	
	func damage(damage: Damage) {
		if(damage.amount > 0) {
			rechargeCounter = rechargeDelay
		}
		shieldBar.damage(damage: damage)
	}
	
	func activate() {
		if(rechargeCounter <= 0) {
			recharge()
		} else {
			rechargeCounter -= 1
		}
	}
	
	private func recharge() {
		shieldBar.current += rechargeAmount
		if(shieldBar.current > shieldBar.max) {
			shieldBar.current = shieldBar.max
		}
	}
}
