//
//  GenericBarVisualizer.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class GenericBarVisualizer: BarVisualizer {
    
    var progressView: UIProgressView
    
    init(progressView: UIProgressView, fraction: Float) {
        self.progressView = progressView
        progressView.setProgress(fraction, animated: true)
        progressView.progressTintColor = UIColor.gray
    }
    
    func changeTo(fraction: Float, colorChange: @escaping (UIColor?) -> ()) {
        progressView.setProgress(fraction, animated: true)
    }
}
