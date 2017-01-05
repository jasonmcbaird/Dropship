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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.white
        backgroundColor = UIColor.darkGray
        
    }
    
    func set(name: String, bars: [String: Float]) {
        textLabel?.text = name
        for i in 0...bars.keys.count - 1 {
            let name = Array(bars.keys)[i]
            let color = colors[name] ?? UIColor.gray
            let barLabel = UILabel()
            barLabel.text = name
            barLabel.frame = CGRect(x: 25, y: 30 * i + 5, width: 50, height: 30)
            contentView.addSubview(barLabel)
            let progressBar = UIProgressView()
            progressBar.progressTintColor = color
            progressBar.frame = CGRect(x: 100, y: 30 * i + 15, width: 100, height: 10)
            self.bars[color] = progressBar
            contentView.addSubview(progressBar)
            progressBar.progress = bars[name]!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
