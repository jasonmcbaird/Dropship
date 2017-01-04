//
//  RandomExecutionStrategy.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class RandomExecutionStrategy: ExecutionStrategy {
    
    func chooseAbility(abilities: [Ability]) -> Ability? {
        if(abilities.count > 0) {
            return abilities[Randomizer.rollRange(0, abilities.count - 1)]
        } else {
            return nil
        }
    }
}
