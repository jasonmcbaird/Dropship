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
    var combat: Initiative!
    var teams: [UITableView: SquadModel] = [:]
    var teamColors: [UITableView: UIColor] = [:]

	override func viewDidLoad() {
		super.viewDidLoad()
        startButton.setTitle("Start", for: UIControlState.normal)
        startButton.frame = CGRect(x: view.frame.width / 2 - 25, y: 50, width: 100, height: 50)
        startButton.addTarget(self, action: #selector(self.startCombat), for: .touchUpInside)
        view.addSubview(startButton)
        newCombat()
	}
    
    func startCombat(sender: UIButton!) {
        if(combat.victory) {
            newCombat()
        }
        combat.playCombat()
    }
    
    func newCombat() {
        for tableView in teams.keys {
            tableView.removeFromSuperview()
            teams.removeValue(forKey: tableView)
            teamColors.removeValue(forKey: tableView)
        }
        combat = CombatFactory().createCombat(type: .gulch)
        var teamCount = 0
        for squad in combat.teams {
            let tableView = UITableView()
            teams[tableView] = squad
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CreatureCell.self, forCellReuseIdentifier: "CreatureCell")
            view.addSubview(tableView)
            tableView.rowHeight = 150
            teamCount += 1
            switch(teamCount) {
            case 1:
                teamColors[tableView] = UIColor(red: 65.0 / 255.0, green: 105.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
            default:
                teamColors[tableView] = UIColor.darkGray
            }
        }
        let width = view.frame.width / CGFloat(teams.keys.count)
        for i in 0...teams.keys.count - 1 {
            Array(teams.keys)[i].frame = CGRect(x: CGFloat(i) * width, y: 150, width: width, height: self.view.frame.height)
        }
    }
}

extension CombatController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams[tableView]?.creatures.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatureCell") as! CreatureCell
        if let creature = teams[tableView]?.creatures[indexPath.row] {
            var bars: [String: Float] = [:]
            for bar in creature.bars {
                bars[bar.name] = bar.fraction
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Current Changed"), object: bar, queue: nil) { _ in
                    cell.update(barName: bar.name, fraction: bar.fraction)
                }
            }
            cell.set(teamColor: teamColors[tableView] ?? UIColor.darkGray, name: creature.name, bars: bars)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

