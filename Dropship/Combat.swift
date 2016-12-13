//
//  Combat.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Combat {
    
    var activatables: [Activatable]
    var ready: Bool {
        for activatable in activatables {
            if(activatable.ready) {
                return true
            }
        }
        return false
    }
    
    init(activatables: [Activatable]) {
        self.activatables = activatables
    }
    
    func playRound() {
        while(ready) {
            for activatable in activatables {
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
        for activatable in activatables {
            activatable.readyUp()
        }
    }
}
