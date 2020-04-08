//
//  CreatePartOneViewController.swift
//  whereyouat
//
//  Created by Sam on 4/8/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class CreatePartOneViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var dob: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destVC = segue.destination as! CreatePartTwoViewController
        
        destVC.firstName = firstName.text!
        destVC.lastName = lastName.text!
        destVC.dob = dob.date

    }
    

}
