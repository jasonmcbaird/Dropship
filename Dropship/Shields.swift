//
//  Shields.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Shields: DamageBar, Activatable {
    
	private var rechargeDelay: Int
	private var rechargeAmount: Int
	private var rechargeCounter: Int
	
	init(maxShields: Int, rechargeDelay: Int, rechargeAmount: Int) {
		self.rechargeDelay = rechargeDelay
		self.rechargeAmount = rechargeAmount
		self.rechargeCounter = 0
        super.init(name: "Shields", max: maxShields)
        
	}
	
	override func damage(damage: Damage) {
		if damage.amount > 0 {
			rechargeCounter = rechargeDelay
		}
        super.damage(damage: damage)
	}
	
	func startTurn() {
		if rechargeCounter <= 1 {
			recharge()
		} else {
			rechargeCounter -= 1
		}
	}
	
	private func recharge() {
		current += rechargeAmount
		if current > max {
			current = max
		}
	}
}
