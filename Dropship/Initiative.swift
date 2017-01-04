//
//  Initiative.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Initiative {

    var squads: [Squad]
    var ready: Bool {
        for readyable in squads {
            if(readyable.ready) {
                return true
            }
        }
        return false
    }
    var victory: Bool {
        var readyCount = 0
        for readyable in squads {
            if(readyable.ready) {
                readyCount += 1
            }
        }
        return readyCount <= 1
    }
    
    init(squads: [Squad]) {
        self.squads = squads
    }
    
    func playRound() {
        while(ready) {
            for readyable in squads {
                if readyable.ready {
                    readyable.startTurn()
                }
            }
        }
    }
    
    func playCombat() {
        while(!victory) {
            playRound()
            newRound()
        }
    }
    
    func newRound() {
        for activatable in squads {
            activatable.readyUp()
        }
    }
}

extension Initiative: CombatModel {
    
    var teams: [SquadModel] {
        return squads as [SquadModel]
    }
}
