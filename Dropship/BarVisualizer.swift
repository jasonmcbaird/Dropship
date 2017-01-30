//
//  BarVisualizer.swift
//  Dropship
//
//  Created by dev1 on 1/27/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class BarVisualizer {
    
    let progressView: UIProgressView
    let barColorThresholds: [Float: UIColor]
    let increaseClosure: () -> Void
    let decreaseClosure: () -> Void
    let zeroClosure: () -> Void
    let defaultBarColor: UIColor
    
    init(defaultBarColor: UIColor, fraction: Float, barColorThresholds: [Float: UIColor] = [:], increaseClosure: @escaping () -> Void = {_ in}, decreaseClosure: @escaping () -> Void = {_ in}, zeroClosure: @escaping () -> Void = {_ in}) {
        self.progressView = UIProgressView()
        self.defaultBarColor = defaultBarColor
        self.barColorThresholds = barColorThresholds
        self.increaseClosure = increaseClosure
        self.decreaseClosure = decreaseClosure
        self.zeroClosure = zeroClosure
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func changeTo(fraction: Float, colorChange: @escaping (UIColor?) -> ()) {
        switch (fraction) {
        case _ where fraction <= 0:
            zeroClosure()
        case _ where fraction > 0 && fraction < progressView.progress:
            decreaseClosure()
        case _ where fraction > progressView.progress:
            increaseClosure()
        default:
            break
        }
        progressView.setProgress(fraction, animated: true)
        updateTint(fraction: fraction)
    }
    
    func updateTint(fraction: Float) {
        progressView.progressTintColor = defaultBarColor
        for threshold in barColorThresholds.keys.sorted(by: { x, y in return x > y }) {
            if progressView.progress <= threshold {
                progressView.progressTintColor = barColorThresholds[threshold] ?? defaultBarColor
            }
        }
    }
}
