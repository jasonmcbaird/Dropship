//
//  RandomTargetStrategy.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class EmptyTargetStrategy: TargetStrategy {
    
    func chooseDamageable() -> Damageable? {
        // TODO: Figure out how to get possible targets
        // TODO: Make this random
        return nil
    }
    
}
