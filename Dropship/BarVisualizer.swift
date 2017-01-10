//
//  BarVisualizer.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

protocol BarVisualizer {
    
    var progressView: UIProgressView { get }
    func changeTo(fraction: Float, colorChange: @escaping (UIColor?) -> ())
    
}
