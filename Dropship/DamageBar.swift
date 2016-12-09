//
//  DamageBar.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class DamageBar: Damageable {
	
	var attributes: [String: Int] = [:]
	
	var current: Int {
		get {
			return attributes[name]!
		} set {
			attributes.updateValue(newValue, forKey: name)
		}
	}
	var max: Int {
		get {
			return attributes[maxName]!
		} set {
			attributes.updateValue(newValue, forKey: maxName)
		}
	}
	private let name: String
	private var maxName: String {
		return name + "Max"
	}
	
	init(name: String, max: Int) {
		self.name = name
		current = max
		self.max = max
	}
	
	func damage(amount: Int, type: DamageType) {
		damage(damage: Damage(amount: amount, type: type))
	}
	
	func damage(damage: Damage) {
		current -= damage.amount
		if(current < 0) {
			let result = -current
			current = 0
			damage.amount = result
		} else {
			damage.amount = 0
		}
	}
}
