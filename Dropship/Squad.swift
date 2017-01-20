//
//  Squad.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Squad {
    
    var readyables: [Readyable]
    var relationships: [Relationship]
    var enemySquads: [Squad] {
        var result: [Squad] = []
        for relationship in relationships {
            switch relationship {
            case .enemy(let otherSquad):
                result.append(otherSquad)
            case .ally(_):
                break
            }
        }
        return result
    }
    var ready: Bool {
        for activatable in readyables {
            if activatable.ready {
                return true
            }
        }
        return false
    }
    
    init(readyables: [Readyable], relationships: [Relationship] = [], setRandomTargetStrategy: Bool = false) {
        self.readyables = readyables
        self.relationships = relationships
        if setRandomTargetStrategy {
            for readyable in readyables {
                if let creature = readyable as? Creature {
                    creature.targetStrategy = RandomTargetStrategy(squad: self)
                }
            }
        }
    }
    
    func startNext() {
        for activatable in readyables {
            if activatable.ready {
                activatable.startTurn()
                return
            }
        }
    }
    
    func readyUp() {
        for activatable in readyables {
            activatable.readyUp()
        }
    }
}

extension Squad: SquadModel {
    
    var creatures: [CreatureModel] {
        var result: [CreatureModel] = []
        for readyable in readyables {
            if let creature = readyable as? Creature {
                result.append(creature)
            }
        }
        return result
    }
    
}
