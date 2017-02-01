//
//  CreatureBuilder.swift
//  Dropship
//
//  Created by dev1 on 1/20/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class CreatureFactory {
    
    lazy var creatureDictionary: [String: () -> Creature]? = self.generateCreatureDictionary(dictionary: JsonImporter().getDictionary(filename: "Creatures") ?? [:])
    
    func create(type: String) -> Creature? {
        return creatureDictionary?[type]?()
    }
    
    private func generateCreatureDictionary(dictionary: [String: Any]) -> [String: () -> Creature] {
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
    
    func parseCreature(name: String, dictionary: [String: Any]) -> (() -> Creature)? {
        return {
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
                let weapon = WeaponFactory().create(type: weaponType) {
                abilities.append(weapon)
            }
            return Creature(name: name, maxHealth: health, damageables: damageables, activatables: activatables, abilities: abilities)
        }
    }
    
}
