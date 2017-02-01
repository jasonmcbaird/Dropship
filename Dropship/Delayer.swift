//
//  Delayer.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

protocol Delayer {
    
    func executeAfterDelay(closure: @escaping () -> (Bool))
    
}
