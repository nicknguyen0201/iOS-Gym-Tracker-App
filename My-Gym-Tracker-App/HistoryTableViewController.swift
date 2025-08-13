//
//  HistoryTableViewController.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/12/25.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    private var sessions: [WorkoutSession] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        loadHistory()
        
    }
   override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadHistory()
    }
    private func loadHistory() {
            sessions = WorkoutHistory.load()
            // Sort newest first for nicer display
            sessions.sort { $0.endTime > $1.endTime }
            tableView.reloadData()
    }
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("sessions.count\(sessions.count)")
        return sessions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of HistoryTableViewCell.")
        }
        
        cell.configure( with: sessions[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                               commit editingStyle: UITableViewCell.EditingStyle,
                               forRowAt indexPath: IndexPath) {
           guard editingStyle == .delete else { return }
           sessions.remove(at: indexPath.row)
           WorkoutHistory.save(sessions)
           tableView.deleteRows(at: [indexPath], with: .automatic)
       }
    
}
