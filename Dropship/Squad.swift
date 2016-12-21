//
//  Squad.swift
//  Dropship
//
//  Created by Jason Baird on 12/12/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class Squad: Readyable {
    
    var readyables: [Readyable]
    var ready: Bool {
        for activatable in readyables {
            if(activatable.ready) {
                return true
            }
        }
        return false
    }
    
    init(readyables: [Readyable]) {
        self.readyables = readyables
    }
    
    func activate() {
        for activatable in readyables {
            activatable.activate()
        }
    }
    
    func readyUp() {
        for activatable in readyables {
            activatable.readyUp()
        }
    }
}
