//
//  BatteryResource.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class BatteryResource: Resource, Activatable, Bar {
    
    var name = "Battery"
    var current: Int {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Current Changed"), object: self)
        }
    }
    var max: Int {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Current Changed"), object: self)
        }
    }
    private var rechargeAmount: Int
    
    init(max: Int, rechargeAmount: Int) {
        self.max = max
        self.current = max
        self.rechargeAmount = rechargeAmount
    }
    
    func canSpend(amount: Int) -> Bool {
        return current >= amount
    }
    
    func spend(amount: Int) {
        self.current -= amount
        if self.current < 0 {
            self.current = 0
        }
    }
    
    func refresh() {
        
    }
    
    func startTurn() {
        current += rechargeAmount
        if current > max {
            current = max
        }
    }
    
}
