//
//  FirstViewController.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/7/25.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet var buttons: [UIButton]!
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let idx = buttons.firstIndex(of: sender as! UIButton) else { return }
       performSegue(withIdentifier: "showDetails", sender: idx)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetails",
                 let dest = segue.destination as? DetailViewController,
                 let idx = sender as? Int else { return }
        dest.selectedIdx = idx
                
            
            
           
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
