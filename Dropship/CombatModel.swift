//
//  CombatModel.swift
//  Dropship
//
//  Created by dev1 on 1/4/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

protocol CombatModel {
    
    var squadModels: [SquadModel] { get }
    var victory: Bool { get }
    
    func playCombat()
    
}
