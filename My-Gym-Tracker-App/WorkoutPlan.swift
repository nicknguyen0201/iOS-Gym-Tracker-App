//
//  WorkoutPlan.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/6/25.
//

import Foundation

//Four-day workout cycle: Arms, Legs, Chest, Back
struct WorkoutPlan {
    //Workout focus for the day
    let name: String
    //Ordered list of exercise names for this plan
    let exercises: [String]

    //All four workout days with exercise names only
    static let allPlans: [WorkoutPlan] = [
        WorkoutPlan(
            name: "Arms Day",
            exercises: [
                "Incline Bench Dumbbell Curl",
                "Cable Tricep Pushdown",
                "Cable Side Delt Flyes",
                "Hammer Curls"
            ]
        ),
        WorkoutPlan(
            name: "Legs Day",
            exercises: [
                "V-Squat / Barbell Anderson Squat",
                "Laying Hamstring Curl",
                "Leg Extensions",
                "Calf Raises"
            ]
        ),
        WorkoutPlan(
            name: "Chest Day",
            exercises: [
                "Bench Press",
                "Incline Dumbbell Press",
                "Chest Press",
                "Pectoral Fly"
            ]
        ),
        WorkoutPlan(
            name: "Back Day",
            exercises: [
                "Cable Rows",
                "Rear Delt Flyes",
                "Single Arm Lat Row",
                "Dips"
            ]
        )
    ]
}

