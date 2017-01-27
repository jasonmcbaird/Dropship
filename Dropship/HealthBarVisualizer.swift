//
//  HealthBarVisualizer.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class HealthBarVisualizer: BarVisualizer {
    
    var progressView: UIProgressView
    
    init(progressView: UIProgressView, fraction: Float) {
        self.progressView = progressView
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func changeTo(fraction: Float, colorChange: @escaping (UIColor?) -> ()) {
        switch (fraction) {
        case _ where fraction <= 0:
            colorChange(UIColor.black)
        case _ where fraction > 0 && fraction < progressView.progress:
            colorChange(UIColor.red)
        case _ where fraction > progressView.progress:
            colorChange(UIColor.green)
        default:
            break
        }
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func updateTint(fraction: Float) {
        switch(fraction) {
        case 0..<0.25:
            progressView.progressTintColor = UIColor.red
        case 0.25..<0.5:
            progressView.progressTintColor = UIColor.yellow
        default:
            progressView.progressTintColor = UIColor.green
        }
    }
}
