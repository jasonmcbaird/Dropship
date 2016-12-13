//
//  Activatable.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol Activatable {
    
    var ready: Bool { get }
	
	func startTurn()
    
    func startRound()
	
}
