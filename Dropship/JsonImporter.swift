//
//  JSONImporter.swift
//  Dropship
//
//  Created by dev1 on 2/1/17.
//  Copyright © 2017 North Forge. All rights reserved.
//

import Foundation

class JsonImporter {
    
    func getDictionary(filename: String) -> [String: Any]? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        return deserializeJSON(url: url)
    }
    
    private func deserializeJSON(url: URL) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as? [String: Any]
        } catch let error {
            print(error)
            return nil
        }
    }
    
}
