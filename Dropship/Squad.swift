//
//  Squad.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Squad: Readyable {
    
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
            if(activatable.ready) {
                return true
            }
        }
        return false
    }
    
    init(readyables: [Readyable], relationships: [Relationship] = [], setRandomTargetStrategy: Bool = false) {
        self.readyables = readyables
        self.relationships = relationships
        if(setRandomTargetStrategy) {
            for readyable in readyables {
                if let unit = readyable as? Unit {
                    unit.targetStrategy = RandomTargetStrategy(squad: self)
                }
            }
        }
    }
    
    func startTurn() {
        for activatable in readyables {
            activatable.startTurn()
        }
    }
    
    func readyUp() {
        for activatable in readyables {
            activatable.readyUp()
        }
    }
}
