//
//  CreatureVisualizer.swift
//  Dropship
//
//  Created by dev1 on 2/15/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class CreatureSprite: UIImageView {
    
    let bars: [BarVisualizer]
    let barBackground: UIView = UIView()
    let barPadding: CGFloat = 3
    
    override var frame: CGRect {
        didSet {
            updateBarFrames()
        }
    }
    
    init(teamColor: UIColor?, bars: [BarVisualizer], imageName: String = "Commando") {
        self.bars = bars
        var imageString = imageName
        if let teamColor = teamColor {
            if teamColor == UIColor.blue {
                imageString = "Red" + imageString
            } else if teamColor == UIColor.red {
                imageString = "Blue" + imageString
            }
        }
        barBackground.layer.borderColor = UIColor.black.cgColor
        barBackground.layer.borderWidth = 1
        super.init(image: UIImage(named: imageString))
        barBackground.backgroundColor = UIColor.white
        addSubview(barBackground)
        backgroundColor = UIColor.clear
        for bar in bars {
            addSubview(bar.progressView)
        }
        updateBarFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBarFrames() {
        if(bars.count > 0) {
            barBackground.frame = CGRect(x: barPadding, y: frame.height - CGFloat(bars.count * 4) - barPadding * 2, width: frame.width - barPadding * 2, height: CGFloat(bars.count * 4) + barPadding)
            for i in 0...bars.count - 1 {
                bars[i].progressView.frame = CGRect(x: barPadding + 2, y: frame.height - CGFloat(4 * i + 4) - barPadding, width: frame.width - barPadding * 2 - 4, height: 2)
            }
        }
    }
    
    func animateAttack() {
        
    }
    
    func animateDamage() {
        
    }
    
}
