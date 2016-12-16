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
	var health: Int {
		return healthResponder.health
	}
	var healthMax: Int {
		return healthResponder.healthMax
	}
    var dead: Bool {
        return healthResponder.dead
    }
    var ready = true
	
	private var healthResponder: Health
	private var damageResponders: [Damageable]
	private var activationResponders: [Activatable]
    private var abilityResponders: [Executable]
	
    init(name: String, health: Int, damageResponders: [Damageable] = [], activationResponders: [Activatable] = [], abilityResponders: [Executable] = []) {
		self.name = name
		self.damageResponders = damageResponders
		self.healthResponder = Health(maxHealth: health)
		self.damageResponders.append(healthResponder)
		self.activationResponders = activationResponders
        self.abilityResponders = abilityResponders
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
        ready = false
	}
    
    func readyUp() {
        ready = true
    }
}
