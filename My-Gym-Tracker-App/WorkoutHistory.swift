//
//  WorkoutHistory.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/12/25.
//

import Foundation
struct WorkoutHistory{
    private static let key = "WorkoutHistory"
    static func load() ->[WorkoutSession]{
        if let savedData = UserDefaults.standard.data(forKey: key){
           guard let workoutSessions = try?JSONDecoder().decode([WorkoutSession].self, from: savedData) else{
                return []
            }
            return workoutSessions
        }
        return []
    }
    static func save(_ workoutSessions: [WorkoutSession]){
        if let data = try? JSONEncoder().encode(workoutSessions){
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
