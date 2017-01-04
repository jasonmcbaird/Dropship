//
//  CombatModel.swift
//  Dropship
//
//  Created by dev1 on 1/4/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

protocol CombatModel {
    
    var teams: [SquadModel] { get }
    
}

protocol SquadModel {
    
    var creatures: [CreatureModel] { get }

}

protocol CreatureModel {
    
    var name: String { get }
    var bars: [Bar] { get }
    
}
