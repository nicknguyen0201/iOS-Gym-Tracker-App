//
//  LogTableViewController.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/10/25.
//

import UIKit

class LogTableViewController: UITableViewController {
    var planNameIdx: Int!
    var selectedWorkoutIdx: Int!
    var setEntries = [SetEntry]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        
        // Set table view delegate
        // Needed to detect row selection: tableView(_:didSelectRowAt:)
        tableView.delegate = self
        
        title=WorkoutPlan.allPlans[planNameIdx].exercises[selectedWorkoutIdx]
        //add a add new set "+" button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,  // this gives you the standard "+"
            target: self,
            action: #selector(addSet)   // method you'll write below
        )
        
        //load, if first time access, let setEntries be []
        guard let unwrap=SetEntry.load(forKey: PersistenceKeys.logKey(planNameIdx: planNameIdx, selectedWorkoutIdx: selectedWorkoutIdx))
        else{fatalError("Couldn't load setEntries, it is nil")}
        self.setEntries=unwrap
        tableView.reloadData()
    }
    @objc private func addSet() {
        let nextSetNumber = (setEntries.last?.set ?? 0) + 1
        let newEntry = SetEntry(set: nextSetNumber, lbs: nil, rep: nil)
        
        setEntries.append(newEntry)
        
        let newIndexPath = IndexPath(row: setEntries.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
    // MARK: - Table view data source
    
    
    // The number of rows to show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return setEntries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeued = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath)
        
        
        guard let cell = dequeued as? LogCellTableViewCell else {
            fatalError("Expected LogCellTableViewCell, got \(type(of: dequeued)). Check identifier & Custom Class.")
        }
        
        let setEntry = setEntries[indexPath.row]
        cell.configure(with: setEntry)
        
        //set delegate so we can call      textFieldDidEndEditing once user is done typing
        cell.lbsField?.delegate = cell
        cell.repField?.delegate = cell
        //when the callback is passed back from the cell, only the following block run to update cell
        cell.onChange = { [weak self, weak cell] currentSet in
            guard let self=self,
                  let cell=cell,
                  let indexPath=self.tableView.indexPath(for: cell)
            else { return }
            //currentSet value arrives in the VC’s closure as the parameter
            self.setEntries[indexPath.row] = currentSet
        }
        return cell
    }
    
    //swipe to delete a cell from the view controller
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            setEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //data persistence when user tap back button
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            tableView.endEditing(true)
            SetEntry.save(entries: setEntries, forKey: PersistenceKeys.logKey(planNameIdx: planNameIdx, selectedWorkoutIdx: self.selectedWorkoutIdx))
            saveExerciseIntoDraft()
        }
        
    }
    private func saveExerciseIntoDraft(){
        tableView.endEditing(true)
        
        let key = getDraftKey(planIdx: planNameIdx)
        var draft = loadDraft(key: key) ?? SessionDraft(planIdx: planNameIdx, startTime: Date(), exercises: [])
        let newExerciseEntry = ExerciseEntry(exerciseIdx: selectedWorkoutIdx, sets: setEntries )
        if let i = draft.exercises.firstIndex(where: { $0.exerciseIdx == selectedWorkoutIdx }){
            //find the old exercise, save new
            draft.exercises[i] = newExerciseEntry
        }else{
            draft.exercises.append(newExerciseEntry)
        }
        saveDraft(draft, key: key)
    }
    
     
}
