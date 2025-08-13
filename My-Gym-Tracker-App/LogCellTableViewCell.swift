//
//  LogCellTableViewCell.swift
//  My-Gym-Tracker-App
//
//  Created by PC on 8/10/25.
//

import UIKit

class LogCellTableViewCell: UITableViewCell, UITextFieldDelegate {
    private var currentSet = SetEntry(set: 1, lbs: 0, rep: 0)
    var onChange: ((SetEntry)->Void)?
    
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var lbsField: UITextField!
    
    @IBOutlet weak var repField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
         
     //   lbsField.delegate = self
      //  repField.delegate = self// will call textFieldDidEndEditing once user is done typing
        //lbsField.keyboardType = .decimalPad
        //repField.keyboardType = .numberPad
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField===lbsField{
            currentSet.lbs = Double(textField.text ?? "")
        }else if textField===repField{
            currentSet.rep = Int(textField.text ?? "")
        }
        onChange?(currentSet)//notify LogTableViewController to display to new field after edit
    }

    func configure(with setEntry:SetEntry){
        currentSet = setEntry
        setLabel.text = "Set #\(currentSet.set)"
        if let lbsValue = setEntry.lbs {
                lbsField.text = String(lbsValue)
            } else {
                lbsField.text = ""
            }
            
            if let repValue = setEntry.rep {
                repField.text = String(repValue)
            } else {
                repField.text = ""
            }
    }

}
