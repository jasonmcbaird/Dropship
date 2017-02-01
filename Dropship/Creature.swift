//
//  Creature.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Creature: Readyable {
	
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
        return !dead && readyPrivate
    }
    var targetStrategy: TargetStrategy
    var abilities: [Ability]
    var position: Position = Position(x: 0, y: 0)
    
    fileprivate var damageables: [Damageable]
    private var readyPrivate: Bool = true
	private var healthBar: DamageBar
	private var activatables: [Activatable]
    private var executionStrategy: ExecutionStrategy
	
    init(name: String, maxHealth: Int, damageables: [Damageable] = [], activatables: [Activatable] = [], abilities: [Ability] = [], executionStrategy: ExecutionStrategy = RandomAbilityStrategy(), targetStrategy: TargetStrategy = EmptyTargetStrategy()) {
		self.name = name
        
		self.damageables = damageables
		self.activatables = activatables
        self.abilities = abilities
        
        self.executionStrategy = executionStrategy
        self.targetStrategy = targetStrategy
        
        self.healthBar = DamageBar(name: "Health", max: maxHealth)
        self.damageables.append(healthBar)
	}
	
	func startTurn() {
        _ = activatables.map({ $0.startTurn() })
        let possibleAbilities = abilities.filter() { ability in
            return ability.canExecute(targetStrategy: targetStrategy)
        }
        executionStrategy.chooseAbility(abilities: possibleAbilities)?.execute(targetStrategy: targetStrategy)
        readyDown()
	}
    
    func readyUp() {
        readyPrivate = true
    }
    
    private func readyDown() {
        readyPrivate = false
    }
}

extension Creature: CreatureModel, Damageable {
    
    var canDamage: Bool {
        return !dead
    }
    
    var bars: [Bar] {
        var result: [Bar] = []
        for damageable in damageables {
            if let bar = damageable as? Bar {
                result.append(bar)
            }
        }
        for ability in abilities {
            if let weapon = ability as? Weapon, let ammo = weapon.resource as? Bar {
                result.append(ammo)
            }
        }
        return result
    }
    
    func damage(damage: Damage) {
        for damageable in damageables {
            damageable.damage(damage: damage)
        }
    }
}
