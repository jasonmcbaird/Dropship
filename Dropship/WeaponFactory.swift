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
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
            let json = WeaponFactory.deserializeJSON(url: url) else {
            return nil
        }
        
        weaponDictionary = WeaponFactory.generateWeaponDictionary(dictionary: json as [String : Any])
    }
    
    func create(type: String) -> Weapon? {
        return weaponDictionary[type]?()
    }
    
    static private func deserializeJSON(url: URL) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any]
        } catch let error {
            print(error)
            return nil
        }
    }
    
    static private func generateWeaponDictionary(dictionary: [String: Any]) -> [String: () -> Weapon] {
        var result: [String: () -> Weapon] = [:]
        for weaponName in dictionary.keys {
            if let weaponDictionary = dictionary[weaponName] as? [String: Any] {
                if let weaponClosure = parseWeapon(name: weaponName, dictionary: weaponDictionary) {
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
        var resource: Resource
        if let ammo = dictionary["ammo"] as? Int {
            resource = AmmoResource(max: ammo)
        } else if let battery = dictionary["battery"] as? Int, let rechargeAmount = dictionary["rechargeAmount"] as? Int {
            resource = BatteryResource(max: battery, rechargeAmount: rechargeAmount)
        } else {
            resource = UnlimitedResource()
        }
        return { return Weapon(damage: damage, resource: resource, rapidFire: rapidFire, accuracy: accuracy) }
    }
}
