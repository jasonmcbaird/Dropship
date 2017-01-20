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
    
    func create(type: String) -> Weapon? {
        return weaponDictionary[type]?()
    }
    
    static private func generateWeaponDictionary(dictionary: [String: Any]) -> [String: () -> Weapon] {
        var result: [String: () -> Weapon] = [:]
        for weaponName in dictionary.keys {
            if let dictionary = dictionary[weaponName] as? [String : Any] {
                if let weaponClosure = parseWeapon(name: weaponName, dictionary: dictionary) {
                    result.updateValue(weaponClosure, forKey: weaponName)
                }
            }
        }
        return result
    }
    
    static private func parseWeapon(name: String, dictionary: [String: Any]) -> (() -> Weapon)? {
        guard let damage = dictionary["damage"] as? Int else {
            return nil
        }
        let rapidFire = dictionary["rapidFire"] as? Int ?? 1
        let accuracy = dictionary["accuracy"] as? Int ?? 100
        if let ammo = dictionary["ammo"] as? Int {
            return { return Weapon(damage: damage, ammo: ammo, rapidFire: rapidFire, accuracy: accuracy) }
        } else if let battery = dictionary["battery"] as? Int, let rechargeAmount = dictionary["rechargeAmount"] as? Int {
            return { return Weapon(damage: damage, battery: battery, rechargeAmount: rechargeAmount, rapidFire: rapidFire, accuracy: accuracy) }
        } else {
            return { return Weapon(damage: damage, rapidFire: rapidFire, accuracy: accuracy) }
        }
    }
}
