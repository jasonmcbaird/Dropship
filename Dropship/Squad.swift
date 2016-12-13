//
//  Squad.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Squad: Activatable {
    
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
    
    func activate() {
        for activatable in activatables {
            activatable.activate()
        }
    }
    
    func readyUp() {
        for activatable in activatables {
            activatable.readyUp()
        }
    }
}
