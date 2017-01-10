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
    let delayer: Delayer
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
    
    convenience init(squads: [Squad], loopTime: Int = 1) {
        self.init(squads: squads, delayer: DelayTimer(loopTime: loopTime))
    }
    
    init(squads: [Squad], delayer: Delayer) {
        self.squads = squads
        self.delayer = delayer
    }
    
    func playCombat() {
        delayer.executeAfterDelay {
            if(self.ready) {
                for squad in self.squads {
                    if(squad.ready) {
                        squad.startNext()
                        return false
                    }
                }
            }
            for activatable in self.squads {
                activatable.readyUp()
            }
            if(!self.victory) {
                self.playCombat()
            }
            return true
        }
    }
}

extension Initiative: CombatModel {
    
    var teams: [SquadModel] {
        return squads as [SquadModel]
    }
}
