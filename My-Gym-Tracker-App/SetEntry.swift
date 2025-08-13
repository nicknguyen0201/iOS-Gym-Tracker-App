//
//  SetEntry.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/11/25.
//

import Foundation
import UIKit


struct SetEntry: Codable{
    var set:Int
    var lbs:Double?
    var rep:Int?
}
//save and load the set entry in each excercise
extension SetEntry{
  
    
    static func save(entries: [SetEntry], forKey getKey: String) {
        let defaults = UserDefaults.standard
        if let data = try? JSONEncoder().encode(entries) {
            defaults.set(data, forKey: getKey)
        }
    }
    
    static func load(forKey getKey: String) -> [SetEntry]? {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: getKey) else { return [SetEntry(set: 1, lbs: nil, rep: nil)] }
        return try? JSONDecoder().decode([SetEntry].self, from: data)
    }
    
}


