//
//  Position.swift
//  Dropship
//
//  Created by dev1 on 1/30/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

struct Position {
    
    var x: Int
    var y: Int
    
    func distanceTo(position otherPosition: Position) -> Int {
        return abs(x - otherPosition.x) + abs(y - otherPosition.y)
    }
    
}
