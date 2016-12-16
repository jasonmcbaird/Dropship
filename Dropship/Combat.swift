//
//  Combat.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Combat {
    
    var squads: [Activatable]
    var ready: Bool {
        for activatable in squads {
            if(activatable.ready) {
                return true
            }
        }
        return false
    }
    
    init(squads: [Activatable]) {
        self.squads = squads
    }
    
    func playRound() {
        while(ready) {
            for activatable in squads {
                if activatable.ready {
                    activatable.activate()
                }
            }
        }
    }
    
    func playCombat() {
        while(ready) {
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
