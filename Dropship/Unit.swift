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
		return healthBar.current
	}
	var healthMax: Int {
		return healthBar.max
	}
    var dead: Bool {
        return healthBar.empty
    }
    var ready: Bool {
        return !dead && privateReady
    }
    var targetStrategy: TargetStrategy
    
    private var privateReady = true
	
	private var healthBar: DamageBar
	private var damageables: [Damageable]
	private var activatables: [Activatable]
    private var executables: [Executable]
    
    private var executionStrategy: ExecutionStrategy
	
    init(name: String, maxHealth: Int, damageables: [Damageable] = [], activatables: [Activatable] = [], executables: [Executable] = [], executionStrategy: ExecutionStrategy = RandomExecutionStrategy(), targetStrategy: TargetStrategy = EmptyTargetStrategy()) {
		self.name = name
        
		self.damageables = damageables
		self.activatables = activatables
        self.executables = executables
        
        self.executionStrategy = executionStrategy
        self.targetStrategy = targetStrategy
        
        self.healthBar = DamageBar(max: maxHealth)
        self.damageables.append(healthBar)
	}
	
	func damage(damage: Damage) {
		for damageable in damageables {
			damageable.damage(damage: damage)
		}
	}
	
	func startTurn() {
		for activatable in activatables {
			activatable.startTurn()
		}
        let possibleExecutables = executables.filter() { executable in
            return executable.canExecute(targetStrategy: targetStrategy)
        }
        executionStrategy.chooseExecutable(executables: possibleExecutables)?.execute(targetStrategy: targetStrategy)
        privateReady = false
	}
    
    func readyUp() {
        privateReady = true
    }
}
