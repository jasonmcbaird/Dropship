//
//  BarModel.swift
//  Dropship
//
//  Created by dev1 on 2/15/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

protocol BarModel: Bar {
    
    var color: UIColor { get }
    var fraction: Float { get }
    
}
