//
//  WeaponFactory.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class WeaponFactory {
    
    var weaponDictionary: [String: () -> Weapon]
    
    init(filename: String = "Weapons") {
        weaponDictionary = generateWeaponDictionary(dictionary: JSON.parseJSON(filename: filename))
    }
    
    func getWeapon(type: String) -> Weapon? {
        return weaponDictionary[type]?()
    }
    
    private func generateWeaponDictionary(dictionary: [String: Any]) -> [String: () -> Weapon] {
        var result: [String: () -> Weapon] = [:]
        for weaponName in dictionary.keys {
            if let dictionary = dictionary[weaponName] as? [String : Any] {
                if let weapon = parseWeapon(name: weaponName, dictionary: dictionary) {
                    result.updateValue(weapon, forKey: weaponName)
                }
            }
        }
        return result
    }
    
    private func parseWeapon(name: String, dictionary: [String: Any]) -> (() -> Weapon)? {
        guard let damage = dictionary["damage"] as? Int else {
            return nil
        }
        if let ammo = dictionary["ammo"] as? Int {
            return { return Weapon(damage: damage, ammo: ammo) }
        } else if let battery = dictionary["battery"] as? Int, let rechargeAmount = dictionary["rechargeAmount"] as? Int {
            return { return Weapon(damage: damage, battery: battery, rechargeAmount: rechargeAmount) }
        } else {
            return { return Weapon(damage: damage) }
        }
    }
}
