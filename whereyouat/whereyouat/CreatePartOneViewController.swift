//
//  CreatePartOneViewController.swift
//  whereyouat
//
//  Created by Sam on 4/8/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

extension Date {
  /// Returns the amount of years from another date
  func years(from date: Date) -> Int {
      return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
  }
}
    
class CreatePartOneViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var advanceButton: UIButton!
    @IBOutlet weak var birthdateErrorLabel: UILabel!
    @IBOutlet weak var advanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        advanceButton.isHidden = true
        advanceLabel.isHidden = true
        advanceButton.isUserInteractionEnabled = false
        dob.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
    }

    @objc func datePickerChanged(picker: UIDatePicker) {
        //print(Date().years(from: dob.date))
        if(Date().years(from: dob.date) >= 13) {
            //print("Over 13, may continue registering")
            birthdateErrorLabel.text = ""
            advanceButton.isHidden = false
            advanceLabel.isHidden = false
            advanceButton.isUserInteractionEnabled = true
        } else {
            birthdateErrorLabel.text = "You must be 13 or older to continue."
            birthdateErrorLabel.textColor = UIColor(red: 255.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            advanceButton.isHidden = true
            advanceLabel.isHidden = true
            advanceButton.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "continue" {
            let destVC = segue.destination as! CreatePartTwoViewController
        
            destVC.firstName = firstName.text!
            destVC.lastName = lastName.text!
            destVC.dob = dob.date
        }

    }
    

}
