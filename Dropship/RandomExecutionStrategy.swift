//
//  RandomExecutionStrategy.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class RandomExecutionStrategy: ExecutionStrategy {
    
    func chooseExecutable(executables: [Executable]) -> Executable? {
        if(executables.count > 0) {
            return executables[Randomizer.rollRange(0, executables.count - 1)]
        } else {
            return nil
        }
    }
}
