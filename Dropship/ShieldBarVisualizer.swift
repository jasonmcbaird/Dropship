//
//  ShieldBarVisualizer.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class ShieldBarVisualizer: BarVisualizer {
    
    var progressView: UIProgressView
    
    init(progressView: UIProgressView, fraction: Float) {
        self.progressView = progressView
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func changeTo(fraction: Float, colorChange: @escaping (UIColor?) -> ()) {
        switch (fraction) {
        case 0..<progressView.progress:
            colorChange(UIColor.cyan)
        case _ where fraction > progressView.progress:
            colorChange(UIColor.blue)
        default:
            break
        }
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func updateTint(fraction: Float) {
        switch(fraction) {
        case 0..<0.5:
            progressView.progressTintColor = UIColor.cyan
        default:
            progressView.progressTintColor = UIColor.blue
        }
    }
}
