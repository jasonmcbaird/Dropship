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
    
    var bars: [UIColor: UIProgressView] = [:]
    var teamColor: UIColor?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.lightText
        backgroundColor = UIColor.darkGray
    }
    
    func set(teamColor: UIColor, name: String, bars: [String: Float]) {
        textLabel?.text = name
        for barName in bars.keys {
            createBar(name: barName, percent: bars[barName]!)
        }
        self.teamColor = teamColor
        backgroundColor = teamColor
    }
    
    func update(barName: String, percent: Float) {
        let color = colors[barName] ?? UIColor.gray
        if let progressBar = bars[color], barName == "Ammo", percent < progressBar.progress {
            fire()
        }
        if let progressBar = bars[color], barName == "Ammo", percent > progressBar.progress {
            reload()
        }
        if barName == "Health", percent <= 0 {
            die()
        } else if let progressBar = bars[color], barName == "Health", percent < progressBar.progress {
            takeDamage()
        }
        if let progressBar = bars[color] {
            progressBar.setProgress(percent, animated: true)
        } else {
            createBar(name: barName, percent: percent)
        }
    }
    
    private func createBar(name: String, percent: Float) {
        let color = colors[name] ?? UIColor.gray
        let barLabel = UILabel()
        barLabel.text = name
        barLabel.frame = CGRect(x: 25, y: 30 * bars.keys.count + 5, width: 50, height: 30)
        contentView.addSubview(barLabel)
        let progressBar = UIProgressView()
        progressBar.progressTintColor = color
        progressBar.frame = CGRect(x: 100, y: 30 * bars.keys.count + 15, width: 100, height: 10)
        self.bars[color] = progressBar
        contentView.addSubview(progressBar)
        progressBar.setProgress(percent, animated: true)
    }
    
    private func fire() {
        backgroundColor = UIColor.lightGray
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            self.backgroundColor = self.teamColor ?? UIColor.darkGray
        }
    }
    
    private func takeDamage() {
        backgroundColor = UIColor.red
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            self.backgroundColor = self.teamColor ?? UIColor.darkGray
        }
    }
    
    private func reload() {
        backgroundColor = UIColor.gray
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.backgroundColor = self.teamColor ?? UIColor.darkGray
        }
    }
    
    private func die() {
        backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
