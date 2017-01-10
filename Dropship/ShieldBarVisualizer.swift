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
            Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { _ in
                colorChange(nil)
            }
        case _ where fraction > progressView.progress:
            colorChange(UIColor.blue)
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                colorChange(nil)
            }
        default:
            break
        }
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func updateTint(fraction: Float) {
        switch(fraction) {
        case 0..<0.25:
            progressView.progressTintColor = UIColor.orange
        case 0.25..<0.5:
            progressView.progressTintColor = UIColor.cyan
        default:
            progressView.progressTintColor = UIColor.blue
        }
    }
}
