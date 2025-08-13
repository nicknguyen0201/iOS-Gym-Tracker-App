//
//  HistoryTableViewCell.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/12/25.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var planName: UILabel!
    @IBOutlet weak var workoutDate: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    
    @IBOutlet weak var exercise1: UILabel!
    @IBOutlet weak var avrLbs1: UILabel!
    @IBOutlet weak var avrSet1: UILabel!
    
    
    @IBOutlet weak var exercise2: UILabel!
    @IBOutlet weak var avrLbs2: UILabel!
    @IBOutlet weak var avrSet2: UILabel!
    
    @IBOutlet weak var exercise3: UILabel!
    @IBOutlet weak var avrLbs3: UILabel!
    @IBOutlet weak var avrSet3: UILabel!
    
    
    @IBOutlet weak var exercise4: UILabel!
    @IBOutlet weak var avrLbs4: UILabel!
    @IBOutlet weak var avrSet4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("HistoryCell awake:", type(of: self))
    }

    func configure(with session: WorkoutSession){
        planName.text = WorkoutPlan.allPlans[session.planIdx].name
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        workoutDate.text = formatter.string(from: session.startTime)
        let minutes = Int(session.duration) / 60
        let seconds = Int(session.duration) % 60
        totalTime.text = "\(minutes)m \(seconds)s"
        let labels = [
                    (exercise1, avrLbs1, avrSet1),
                    (exercise2, avrLbs2, avrSet2),
                    (exercise3, avrLbs3, avrSet3),
                    (exercise4, avrLbs4, avrSet4)
                ]
        for (i, exerciseEntry) in session.exercises.enumerated() {
            let exerciseName = WorkoutPlan.allPlans[session.planIdx].exercises[i]
            labels[i].0?.text = exerciseName
            
            // Average lbs
            let allLbs = exerciseEntry.sets.compactMap { $0.lbs }
            let avgLbs = allLbs.isEmpty ? 0 : allLbs.reduce(0, +) / Double(allLbs.count)
            labels[i].1?.text = String(format: "%.1f lbs", avgLbs)
            
            // Average reps
            let allReps = exerciseEntry.sets.compactMap { $0.rep }
            let avgReps = allReps.isEmpty ? 0 : Double(allReps.reduce(0, +)) / Double(allReps.count)
            labels[i].2?.text = String(format: "%.1f reps", avgReps)
        }
    }

}
