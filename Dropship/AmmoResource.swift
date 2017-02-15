//
//  AmmoResource.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation
import UIKit

class AmmoResource: Resource, Bar, BarModel {
    
    var name: String
    var color = UIColor.brown
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
    
    init(name: String = "Ammo", max: Int) {
        self.name = name
        self.max = max
        self.current = max
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
        self.current = max
    }
    
}
