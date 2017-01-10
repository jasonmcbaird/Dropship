//
//  AmmoBar.swift
//  Dropship
//
//  Created by dev1 on 1/10/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class AmmoBarVisualizer: BarVisualizer {
    
    var progressView: UIProgressView
    
    init(progressView: UIProgressView, fraction: Float) {
        self.progressView = progressView
        progressView.setProgress(fraction, animated: true)
        progressView.progressTintColor = UIColor.brown
    }
    
    func changeTo(fraction: Float, colorChange: @escaping (UIColor?) -> ()) {
        switch (fraction) {
        case 0..<progressView.progress:
            colorChange(UIColor.lightGray)
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
                colorChange(nil)
            }
        case progressView.progress...1:
            colorChange(UIColor.brown)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                colorChange(nil)
            }
        default:
            break
        }
        progressView.setProgress(fraction, animated: true)
    }
}
