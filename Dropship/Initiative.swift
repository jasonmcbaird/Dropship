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
    
    init(squads: [Squad], loopTime: Double = 1) {
        self.squads = squads
        self.loopTime = loopTime
    }
    
    func playCombat() {
        Timer.scheduledTimer(withTimeInterval: loopTime, repeats: true) { timer in
            if(self.ready) {
                for squad in self.squads {
                    if(squad.ready) {
                        squad.startNext()
                        return
                    }
                }
            }
            timer.invalidate()
            self.newRound()
            if(!self.victory) {
                self.playCombat()
            }
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
