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

	override func viewDidLoad() {
		super.viewDidLoad()
        combat = CombatFactory().createCombat(type: .gulch)
        for squad in combat.teams {
            let tableView = UITableView()
            teams[tableView] = squad
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CreatureCell.self, forCellReuseIdentifier: "CreatureCell")
            view.addSubview(tableView)
            tableView.rowHeight = 150
            for creature in squad.creatures {
                for bar in creature.bars {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Current Changed"), object: bar, queue: nil) { _ in
                        tableView.reloadData()
                    }
                }
            }
        }
        let width = view.frame.width / CGFloat(teams.keys.count)
        for i in 0...teams.keys.count - 1 {
            Array(teams.keys)[i].frame = CGRect(x: CGFloat(i) * width, y: 150, width: width, height: self.view.frame.height)
        }
        startButton.setTitle("Start", for: UIControlState.normal)
        startButton.frame = CGRect(x: view.frame.width / 2 - 25, y: 50, width: 100, height: 50)
        startButton.addTarget(self, action: #selector(self.startCombat), for: .touchUpInside)
        view.addSubview(startButton)
	}
    
    func startCombat(sender: UIButton!) {
        combat.playCombat()
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
                bars[bar.name] = bar.percent
            }
            cell.set(name: creature.name, bars: bars)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

