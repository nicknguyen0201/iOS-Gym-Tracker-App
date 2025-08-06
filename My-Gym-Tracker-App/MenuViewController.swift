//
//  MenuViewController.swift
//  
//
//  Created by PC on 8/5/25.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showDetails", sender: sender)
    }
    
    @IBOutlet var buttons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard
                let destinationViewController = segue.destination as? DetailViewController,
                let tappedButton=sender as? UIButton,
                let idx=buttons.firstIndex(of: tappedButton)
            else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            
        }
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
