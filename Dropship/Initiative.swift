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
    let loopTime: Double
    var ready: Bool {
        for squad in squads {
            if(squad.ready) {
                return true
            }
        }
        return false
    }
    var victory: Bool {
        var readyCount = 0
        for squad in squads {
            if(squad.ready) {
                readyCount += 1
            }
        }
        return readyCount <= 1
    }
    
    init(squads: [Squad], loopTime: Double = 0.5) {
        self.squads = squads
        self.loopTime = loopTime
    }
    
    func playRound() {
        while(ready) {
            for squad in squads {
                if squad.ready {
                    squad.startTurn()
                }
            }
        }
    }
    
    func playCombat() {
        Timer.scheduledTimer(withTimeInterval: loopTime, repeats: true, block: { timer in
            if(!self.victory) {
                self.playRound()
                self.newRound()
            } else {
                timer.invalidate()
            }
        })
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
