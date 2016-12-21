//
//  Ability.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol Executable {
    
    func canExecute(targetStrategy: TargetStrategy) -> Bool
    
    func execute(targetStrategy: TargetStrategy)
    
}
