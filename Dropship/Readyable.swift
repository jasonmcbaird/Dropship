//
//  Readyable.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol Readyable: Activatable {
    
    var ready: Bool { get }
    func readyUp()
    
}
