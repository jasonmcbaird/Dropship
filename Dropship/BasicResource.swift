//
//  BasicResource.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class BasicResource: Resource, Bar {
    
    var current: Int
    var max: Int
    
    init(max: Int) {
        self.max = max
        self.current = max
    }
    
    func canSpend(amount: Int) -> Bool {
        return current >= amount
    }
    
    func spend(amount: Int) {
        self.current -= amount
        if(self.current < 0) {
            self.current = 0
        }
    }
    
    func refresh() {
        self.current = max
    }
    
}
