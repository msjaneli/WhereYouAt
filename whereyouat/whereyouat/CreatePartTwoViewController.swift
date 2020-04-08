//
//  CreatePartTwoViewController.swift
//  whereyouat
//
//  Created by Sam on 4/8/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class CreatePartTwoViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    var firstName:String = ""
    var lastName:String = ""
    var dob:Date = Date()
    
    var api = API.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(firstName)
        print(lastName)
        print(dob)

        
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
