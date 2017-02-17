//
//  MapController.swift
//  Dropship
//
//  Created by dev1 on 2/15/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation
import UIKit

class MapController: UIViewController {

    var combatModel: Combat!
    var sprites: [CreatureSprite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeModels()
        initializeViews()
    }
    
    private func initializeModels() {
        combatModel = CombatFactory().create(type: .gulch)
    }
    
    private func initializeViews() {
        view.backgroundColor = UIColor.lightGray
        var teamColor = UIColor.red
        for squad in combatModel.squads {
            for creature in squad.creatures {
                initializeCreatureView(creature: creature, teamColor: teamColor)
            }
            teamColor = UIColor.blue
        }
    }
    
    private func initializeCreatureView(creature: CreatureModel, teamColor: UIColor) {
        let barVisualizers = creature.bars.flatMap({ bar in BarVisualizer(defaultBarColor: bar.color, fraction: bar.fraction) })
        let sprite = CreatureSprite(teamColor: teamColor, bars: barVisualizers)
        sprites.append(sprite)
        let height: CGFloat = 60
        sprite.frame = CGRect(x: CGFloat(Randomizer.rollDie(Int(view.frame.width - height))), y: CGFloat(Randomizer.rollDie(Int(view.frame.height - height))), width: height, height: height)
        view.addSubview(sprite)
    }
    
}
