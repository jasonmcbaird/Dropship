//
//  ViewController.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import UIKit

class CombatController: UIViewController {
    
    var startButton: UIButton = UIButton()
    var combat: CombatModel!
    var squads: [UITableView: SquadModel] = [:]
    var teamColors: [UITableView: UIColor] = [:]

	override func viewDidLoad() {
		super.viewDidLoad()
        startButton.setTitle("Start", for: UIControlState.normal)
        startButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        startButton.addTarget(self, action: #selector(self.startCombat), for: .touchUpInside)
        alignElements()
        view.addSubview(startButton)
        NotificationCenter.default.addObserver(self, selector: #selector(self.alignElements), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
	}
    
    func startCombat(sender: UIButton?) {
        newCombat()
        combat.playCombat()
    }
    
    func newCombat() {
        clearTableViews()
        combat = CombatFactory().create(type: .gulch)
        var teamCount = 0
        for squad in combat.squadModels {
            switch(teamCount) {
            case 0:
                setupTableView(squad: squad, color: UIColor(red: 65.0 / 255.0, green: 105.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0))
            default:
                setupTableView(squad: squad, color: UIColor.darkGray)
            }
            teamCount += 1
        }
        alignElements()
    }
    
    func clearTableViews() {
        for tableView in squads.keys {
            tableView.removeFromSuperview()
            squads.removeValue(forKey: tableView)
            teamColors.removeValue(forKey: tableView)
        }
    }
    
    func setupTableView(squad: SquadModel, color: UIColor) {
        let tableView = UITableView()
        squads[tableView] = squad
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CreatureCell.self, forCellReuseIdentifier: "CreatureCell")
        view.addSubview(tableView)
        tableView.rowHeight = 100
        teamColors[tableView] = color
    }
    
    func alignElements() {
        startButton.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 50)
        if squads.keys.count > 0 {
            let width = view.frame.width / CGFloat(squads.keys.count)
            for i in 0...squads.keys.count - 1 {
                Array(squads.keys)[i].frame = CGRect(x: CGFloat(i) * width, y: 100, width: width, height: self.view.frame.height)
            }
        }
    }
}

extension CombatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return squads[tableView]?.creatures.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let creature = squads[tableView]?.creatures[indexPath.row] {
            return createCell(creature: creature, teamColor: teamColors[tableView] ?? UIColor.darkGray)
        }
        return CreatureCell(style: UITableViewCellStyle.default, reuseIdentifier: "Creature Cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createCell(creature: CreatureModel, teamColor: UIColor) -> UITableViewCell {
        var bars: [String: Float] = [:]
        for bar in creature.bars {
            bars[bar.name] = bar.fraction
        }
        let cell = CreatureCell(teamColor: teamColor, name: creature.name, bars: bars, reuseIdentifier: "Creature Cell")
        for bar in creature.bars {
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Current Changed"), object: bar, queue: nil) { _ in
                cell.update(barName: bar.name, fraction: bar.fraction)
            }
        }
        return cell
    }
    
}

