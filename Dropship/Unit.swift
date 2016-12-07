//
//  Unit.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Unit: Damageable, Activatable {
	
	public var name: String
	public var attributes: [String: Int] {
		var result: [String: Int] = [:]
		for responder in damageResponders {
			for key in responder.attributes.keys {
				result.updateValue(responder.attributes[key]!, forKey: key)
			}
		}
		return result
	}
	
	private var damageResponders: [Damageable]
	private var activationResponders: [Activatable]
	
	public init(name: String, health: Int, damageResponders: [Damageable], activationResponders: [Activatable]) {
		self.name = name
		self.damageResponders = damageResponders
		let healthSoak = Health(maxHealth: health)
		self.damageResponders.append(healthSoak)
		self.activationResponders = activationResponders
	}
	
	public func damage(damage: Damage) {
		for responder in damageResponders {
			responder.damage(damage: damage)
		}
	}
	
	public func activate() {
		for responder in activationResponders {
			responder.activate()
		}
	}
}
