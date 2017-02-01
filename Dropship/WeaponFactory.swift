//
//  WeaponFactory.swift
//  Dropship
//
//  Created by Jason Baird on 12/23/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import Foundation

class WeaponFactory {
    
    lazy var weaponDictionary: [String: () -> Weapon]? = self.generateWeaponDictionary(dictionary: JsonImporter().getDictionary(filename: "Weapons") ?? [:])
    
    func create(type: String) -> Weapon? {
        return weaponDictionary?[type]?()
    }
    
    private func generateWeaponDictionary(dictionary: [String: Any]) -> [String: () -> Weapon] {
        var result: [String: () -> Weapon] = [:]
        for weaponName in dictionary.keys {
            if let weaponDictionary = dictionary[weaponName] as? [String: Any],
                let weaponClosure = parseWeapon(name: weaponName, dictionary: weaponDictionary) {
                result.updateValue(weaponClosure, forKey: weaponName)
            }
        }
        return result
    }
    
    private func parseWeapon(name: String, dictionary: [String: Any]) -> (() -> Weapon)? {
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
