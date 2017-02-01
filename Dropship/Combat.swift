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
        delayer.executeAfterDelay() { [weak self] _ in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "New Turn"), object: self)
            guard let combat = self,
                let readySquads = self?.squads.filter({ return $0.ready }) else {
                return false
            }
            if readySquads.count >= 1 {
                readySquads[0].startNext()
                return true
            } else {
                _ = combat.squads.map({ squad in squad.readyUp() })
                if !combat.victory {
                    combat.playCombat()
                }
                return false
            }
        }
    }
}

extension Combat: CombatModel {
    
    var squadModels: [SquadModel] {
        return squads as [SquadModel]
    }
    
}
