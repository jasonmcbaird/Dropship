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
    var ready: Bool {
        for activatable in readyables {
            if(activatable.ready) {
                return true
            }
        }
        return false
    }
    
    init(readyables: [Readyable]) {
        self.readyables = readyables
    }
    
    func startNext() {
        for activatable in readyables {
            if(activatable.ready) {
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
