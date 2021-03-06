//
//  Bar.swift
//  Dropship
//
//  Created by dev1 on 12/21/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol Bar {
    
    var name: String { get }
    var current: Int { get }
    var max: Int { get }
    
    var empty: Bool { get }
    var full: Bool { get }
    var fraction: Float { get }
    
}

extension Bar {
    
    var empty: Bool {
        return current <= 0
    }
    
    var full: Bool {
        return current >= max
    }
    
    var fraction: Float {
        get {
            return Float(current) / Float(max)
        }
    }
    
}
