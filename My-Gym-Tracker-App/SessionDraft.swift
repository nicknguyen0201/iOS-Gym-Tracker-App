//
//  SessionDraft.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/12/25.
//

import Foundation
struct WorkoutSession: Codable {
    let startTime: Date         // when user began this session
    let endTime: Date           // when user finished (on Save & Clear)
    let planIdx: Int //"Arms Day, [0]"
    var exercises:[ExerciseEntry]//will have 4 setEntries because we have 4 exercises
    var duration: TimeInterval { endTime.timeIntervalSince(startTime) } // seconds
}

struct ExerciseEntry: Codable {
    let exerciseIdx: Int //"tricep push down, [1]"
    var sets:[SetEntry]
}
//save and load the excercises together temporarily in a draft until we finished all 4 exercise to make a complete workout session
struct SessionDraft: Codable {
    var planIdx: Int
    var startTime: Date
    var exercises: [ExerciseEntry]
}
func getDraftKey(planIdx: Int, day:Date=Date()) -> String {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    let dateStr = df.string(from: day)
    return "sessionDraft-\(planIdx)-\(dateStr)"
    
}
func loadDraft(key: String)->SessionDraft?{
    if let savedData = UserDefaults.standard.data(forKey: key){
        do{
            return try JSONDecoder().decode(SessionDraft.self, from: savedData)
        }catch{
            print("Failed to load draft: \(error)")
            return nil
        }
    }else{
        return nil
    }
}

func saveDraft(_ draft:SessionDraft, key:String){
    if let savedData = try? JSONEncoder().encode(draft){
        UserDefaults.standard.set(savedData, forKey: key)
    }
}




