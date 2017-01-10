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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.lightText
        backgroundColor = UIColor.darkGray
    }
    
    func set(teamColor: UIColor, name: String, bars: [String: Float]) {
        textLabel?.text = name
        for barName in bars.keys {
            createBar(name: barName, fraction: bars[barName]!)
        }
        self.teamColor = teamColor
        backgroundColor = teamColor
    }
    
    func update(barName: String, fraction: Float) {
        let color = colors[barName] ?? UIColor.gray
        if let visualizer = bars[color] {
            visualizer.changeTo(fraction: fraction, colorChange: { [unowned self] color in
                self.backgroundColor = color ?? self.teamColor
            })
        } else {
            createBar(name: barName, fraction: fraction)
        }
    }
    
    private func createBar(name: String, fraction: Float) {
        let color = colors[name] ?? UIColor.gray
        let barLabel = UILabel(frame: CGRect(x: 20, y: 30 * bars.keys.count + 5, width: 65, height: 30))
        barLabel.text = name
        contentView.addSubview(barLabel)
        let progressView = UIProgressView()
        progressView.frame = CGRect(x: 100, y: 30 * bars.keys.count + 15, width: 100, height: 10)
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
    }
    
    private func changeBackground(color: UIColor, until: Double) {
        backgroundColor = color
        if(until > 0) {
            Timer.scheduledTimer(withTimeInterval: until, repeats: false) { _ in
                self.backgroundColor = self.teamColor ?? UIColor.darkGray
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
