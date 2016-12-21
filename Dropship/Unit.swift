//
//  Unit.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Unit: Damageable, Readyable {
	
	var name: String
	var health: Int {
		return healthBar.health
	}
	var healthMax: Int {
		return healthBar.healthMax
	}
    var dead: Bool {
        return healthBar.dead
    }
    var ready = true
	
	private var healthBar: Health
	private var damageables: [Damageable]
	private var activatables: [Activatable]
    private var executables: [Executable]
	
    init(name: String, maxHealth: Int, damageables: [Damageable] = [], activatables: [Activatable] = [], executables: [Executable] = []) {
		self.name = name
        
		self.damageables = damageables
		self.activatables = activatables
        self.executables = executables
        
        self.healthBar = Health(maxHealth: maxHealth)
        self.damageables.append(healthBar)
	}
	
	func damage(damage: Damage) {
		for responder in damageables {
			responder.damage(damage: damage)
		}
	}
	
	func startTurn() {
		for responder in activatables {
			responder.startTurn()
		}
        ready = false
	}
    
    func readyUp() {
        ready = true
    }
}
