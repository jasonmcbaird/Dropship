//
//  CreatureBuilder.swift
//  Dropship
//
//  Created by dev1 on 1/20/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class CreatureFactory {
    
    let creatureDictionary: [String: () -> Creature]
    
    init?(filename: String = "Creatures") {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                if let json = try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any] {
                    creatureDictionary = CreatureFactory.generateCreatureDictionary(dictionary: json as [String : Any])
                } else {
                    return nil
                }
            } catch let error {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    func create(type: String) -> Creature? {
        return creatureDictionary[type]?()
    }
    
    static private func generateCreatureDictionary(dictionary: [String: Any]) -> [String: () -> Creature] {
        var result: [String: () -> Creature] = [:]
        for creatureName in dictionary.keys {
            if let dictionary = dictionary[creatureName] as? [String : Any] {
                if let creatureClosure = parseCreature(name: creatureName, dictionary: dictionary) {
                    result.updateValue(creatureClosure, forKey: creatureName)
                }
            }
        }
        return result
    }
    
    static func parseCreature(name: String, dictionary: [String: Any]) -> (() -> Creature)? {
        let health = dictionary["health"] as? Int ?? 15
        var abilities: [Ability] = []
        var damageables: [Damageable] = []
        var activatables: [Activatable] = []
        if let armorAmount = dictionary["armor"] as? Int {
            damageables.append(Armor(amount: armorAmount))
        }
        if let shieldsDictionary = dictionary["shields"] as? [String: Any],
            let maxShields = shieldsDictionary["maxShields"] as? Int,
            let rechargeDelay = shieldsDictionary["rechargeDelay"] as? Int,
            let rechargeAmount = shieldsDictionary["rechargeAmount"] as? Int {
            let shields = Shields(maxShields: maxShields, rechargeDelay: rechargeDelay, rechargeAmount: rechargeAmount)
            damageables.append(shields)
            activatables.append(shields)
        }
        if let weaponType = dictionary["weapon"] as? String,
            let weapon = WeaponFactory()?.create(type: weaponType) {
            abilities.append(weapon)
        }
        
        return {
            return Creature(name: name, maxHealth: health, damageables: damageables, activatables: activatables, abilities: abilities)
        }
    }
    
}
