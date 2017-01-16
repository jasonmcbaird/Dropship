//
//  WeaponFactory.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class WeaponFactory {
    
    let weaponDictionary: [String: () -> Weapon]
    
    init?(filename: String = "Weapons") {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                if let json = try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any] {
                    weaponDictionary = WeaponFactory.generateWeaponDictionary(dictionary: json as [String : Any])
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
    
    func getWeapon(type: String) -> Weapon? {
        return weaponDictionary[type]?()
    }
    
    static private func generateWeaponDictionary(dictionary: [String: Any]) -> [String: () -> Weapon] {
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
    
    static private func parseWeapon(name: String, dictionary: [String: Any]) -> (() -> Weapon)? {
        guard let damage = parseToInt(json: dictionary["damage"]) else {
            return nil
        }
        let rapidFire = parseToInt(json: dictionary["rapidFire"]) ?? 1
        let accuracy = parseToInt(json: dictionary["accuracy"]) ?? 100
        if let ammo = parseToInt(json: dictionary["ammo"]) {
            return { return Weapon(damage: damage, ammo: ammo, rapidFire: rapidFire, accuracy: accuracy) }
        } else if let battery = parseToInt(json: dictionary["battery"]), let rechargeAmount = parseToInt(json: dictionary["rechargeAmount"]) {
            return { return Weapon(damage: damage, battery: battery, rechargeAmount: rechargeAmount, rapidFire: rapidFire, accuracy: accuracy) }
        } else {
            return { return Weapon(damage: damage, rapidFire: rapidFire, accuracy: accuracy) }
        }
    }
    
    static private func parseToInt(json: Any?) -> Int? {
        guard let string = json as? String else {
            return nil
        }
        return Int(string) ?? nil
    }
}
