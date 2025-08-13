//
//  PersistenceKeys.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/12/25.
//

import Foundation
enum PersistenceKeys{
    static func logKey(planNameIdx: Int, selectedWorkoutIdx: Int)-> String {
        return "log-\(String(describing: planNameIdx))-\(String(describing: selectedWorkoutIdx))"
    }
    
    
}
