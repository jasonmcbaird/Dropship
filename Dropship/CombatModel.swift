//
//  CombatModel.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol CombatModel {
    
    var squadModels: [SquadModel] { get }
    var victory: Bool { get }
    
    func playCombat()
    
}
