//
//  CombatModel.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class CombatModel {
    
    var initiative: Initiative
    
    init(readyableSets: [[Readyable]]) {
        var squads: [Squad] = []
        for readyableSet in readyableSets {
            squads.append(Squad(readyables: readyableSet, setRandomTargetStrategy: true))
        }
        initiative = Initiative(squads: squads)
        setAllSquadsAreEnemies()
    }
    
    func setAllSquadsAreEnemies() {
        for squad in initiative.squads {
            for enemy in initiative.squads {
                if(enemy !== squad) {
                    squad.relationships.append(Relationship.enemy(enemy))
                }
            }
        }
    }
    
    func playCombat() {
        initiative.playCombat()
    }
}
