//
//  DetailViewController.swift
//  
//
//  Created by PC on 8/5/25.
//

import UIKit

class DetailViewController: UIViewController {
  
    var selectedIdx: Int!
    private var sessionStartTime: Date?

    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let idx = buttons.firstIndex(of: sender as! UIButton) else { return }
       performSegue(withIdentifier: "showLogs", sender: idx)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if sessionStartTime == nil {
            sessionStartTime = Date()
        }
        guard let i = selectedIdx,
                      WorkoutPlan.allPlans.indices.contains(i) else {
                    assertionFailure("selectedIdx not set or out of range")
                    return
                }
        print("button count is \(buttons.count)")
        let plan = WorkoutPlan.allPlans[i]
        title = "\(plan.name)"
        navigationItem.largeTitleDisplayMode = .always
        let names = plan.exercises
        let count=buttons.count
        for idx in 0..<count {
            let btn=buttons[idx]
            btn.setTitle(names[idx], for: .normal)
            btn.isHidden = false
            btn.isEnabled = true
            btn.tag=idx
        }
       //change back button to a save and exit button, so we can save workout and clear all field
        navigationItem.hidesBackButton = true
        //disable backward swipe to bypass save and exit
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveAndExitTapped))
        
    }
    @objc private func saveAndExitTapped() {
        
        let alert = UIAlertController(title: "Save Workout", message: "Are you sure you want to save this workout and exit?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.saveToHistoryAndClear(planIdx: self.selectedIdx) //pass in "arms day"
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    private func saveToHistoryAndClear(planIdx: Int) {
        let key = getDraftKey(planIdx: planIdx)
        guard let draft = loadDraft(key: key) else { return }
        let end = Date()
        //create a complete workoutsession
        let workoutSession = WorkoutSession(
            startTime: sessionStartTime!, endTime: end, planIdx: self.selectedIdx, exercises: draft.exercises)
        var history = WorkoutHistory.load()
        history.append(workoutSession)
        WorkoutHistory.save(history)
        //clear the draft from local mem
        UserDefaults.standard.removeObject(forKey: key)
        for i in 0..<4 {
            let key = PersistenceKeys.logKey( planNameIdx: planIdx, selectedWorkoutIdx: i)
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showLogs",
                 let dest = segue.destination as? LogTableViewController,
                 let idx = sender as? Int else { return }
        
        dest.selectedWorkoutIdx = idx
        dest.planNameIdx = selectedIdx
    }
    

}
