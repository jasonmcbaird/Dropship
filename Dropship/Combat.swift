//
//  Combat.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Combat {
    
    var squads: [Readyable]
    var ready: Bool {
        for readyable in squads {
            if(readyable.ready) {
                return true
            }
        }
        return false
    }
    
    init(squads: [Readyable]) {
        self.squads = squads
    }
    
    func playRound() {
        while(ready) {
            for readyable in squads {
                if readyable.ready {
                    readyable.activate()
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
