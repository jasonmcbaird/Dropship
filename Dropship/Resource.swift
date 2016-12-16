//
//  Resource.swift
//  Dropship
//
//  Created by dev1 on 12/16/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

protocol Resource {
    
    func canSpend(amount: Int) -> Bool
    func spend(amount: Int)
    func refresh()
    
}
