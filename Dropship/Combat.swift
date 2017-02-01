//
//  Combat.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Combat {
    
    var squads: [Squad]
    let delayer: Delayer
    var victory: Bool {
        return squads.filter({ return $0.ready }).count <= 1
    }
    
    convenience init(squads: [Squad], loopTime: Int = 1) {
        self.init(squads: squads, delayer: DelayTimer(loopTime: loopTime))
    }
    
    init(squads: [Squad], delayer: Delayer) {
        self.squads = squads
        self.delayer = delayer
    }
    
    func playCombat() {
        delayer.executeAfterDelay() {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "New Turn"), object: self)
            for squad in self.squads {
                if squad.ready {
                    squad.startNext()
                    return false
                }
            }
            for squad in self.squads {
                squad.readyUp()
            }
            if !self.victory {
                self.playCombat()
            }
            return true
        }
    }
}

extension Combat: CombatModel {
    
    var squadModels: [SquadModel] {
        return squads as [SquadModel]
    }
    
}
