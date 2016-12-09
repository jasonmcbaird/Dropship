//
//  Unit.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Unit: Damageable, Activatable {
	
	var name: String
	var attributes: [String: Int] {
		var result: [String: Int] = [:]
		for responder in damageResponders {
			for key in responder.attributes.keys {
				result.updateValue(responder.attributes[key]!, forKey: key)
			}
		}
		return result
	}
	var health: Int {
		return healthResponder.health
	}
	var healthMax: Int {
		return healthResponder.healthMax
	}
	
	private var healthResponder: Health
	private var damageResponders: [Damageable]
	private var activationResponders: [Activatable]
	
	init(name: String, health: Int, damageResponders: [Damageable], activationResponders: [Activatable]) {
		self.name = name
		self.damageResponders = damageResponders
		self.healthResponder = Health(maxHealth: health)
		self.damageResponders.append(healthResponder)
		self.activationResponders = activationResponders
	}
	
	func damage(damage: Damage) {
		for responder in damageResponders {
			responder.damage(damage: damage)
		}
	}
	
	func activate() {
		for responder in activationResponders {
			responder.activate()
		}
	}
}
