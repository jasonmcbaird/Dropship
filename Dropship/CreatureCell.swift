//
//  UnitTableCell.swift
//  Dropship
//
//  Created by dev1 on 1/5/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class CreatureCell: UITableViewCell {
    
    let colors = [
        "Health": UIColor.red,
        "Ammo": UIColor.brown,
        "Shields": UIColor.blue
    ]
    
    var bars: [UIColor: BarVisualizer] = [:]
    var teamColor: UIColor?
    
    convenience init(teamColor: UIColor, name: String, bars: [String: Float], reuseIdentifier: String?) {
        self.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        textLabel?.text = name
        for barName in bars.keys {
            createBar(name: barName, fraction: bars[barName]!)
        }
        self.teamColor = teamColor
        backgroundColor = teamColor
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.lightText
        backgroundColor = UIColor.darkGray
        layer.masksToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2.0
    }
    
    override func layoutSubviews() {
        textLabel?.frame = CGRect(x: 0, y: frame.height - 40, width: frame.width, height: 20)
        textLabel?.textAlignment = NSTextAlignment.center
    }
    
    func update(barName: String, fraction: Float) {
        let color = colors[barName] ?? UIColor.gray
        if let visualizer = bars[color] {
            visualizer.changeTo(fraction: fraction) { [unowned self] color in
                self.backgroundColor = color ?? self.teamColor
            }
        } else {
            createBar(name: barName, fraction: fraction)
        }
    }
    
    func resetColor() {
        if(backgroundColor != UIColor.black) {
            backgroundColor = teamColor
        }
    }
    
    private func createBar(name: String, fraction: Float) {
        let color = colors[name] ?? UIColor.gray
        let barLabel = UILabel(frame: CGRect(x: 25, y: 20 * bars.keys.count, width: 25, height: 15))
        barLabel.adjustsFontSizeToFitWidth = true
        barLabel.text = name
        contentView.addSubview(barLabel)
        let progressView = UIProgressView()
        progressView.frame = CGRect(x: 20, y: 20 * bars.keys.count + 15, width: 100, height: 10)
        switch(name) {
        case "Health":
            self.bars[color] = HealthBarVisualizer(progressView: progressView, fraction: fraction)
        case "Ammo":
            self.bars[color] = AmmoBarVisualizer(progressView: progressView, fraction: fraction)
        case "Shields":
            self.bars[color] = ShieldBarVisualizer(progressView: progressView, fraction: fraction)
        default:
            self.bars[color] = GenericBarVisualizer(progressView: progressView, fraction: fraction)
        }
        contentView.addSubview(progressView)
        update(barName: name, fraction: fraction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
