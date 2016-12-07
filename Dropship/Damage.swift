//
//  Damage.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Damage {
	
	var amount: Int
	var type: DamageType
	
	init(amount: Int, type: DamageType = DamageType.physical) {
		self.amount = amount
		self.type = type
	}
}
