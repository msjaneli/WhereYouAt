//
//  CreatePartTwoViewController.swift
//  whereyouat
//
//  Created by Sam on 4/8/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class CreatePartTwoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    var firstName:String = ""
    var lastName:String = ""
    var dob:Date = Date()
    
    @IBOutlet weak var registerButton: UIButton!
    
    var api = API.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        confirmEmail.delegate = self
        password.delegate = self
        confirmPassword.delegate = self

        registerButton.isUserInteractionEnabled = false
        registerButton.addTarget(self, action:#selector(buttonClick), for: .touchUpInside)
        
        email.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        confirmEmail.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        password.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        confirmPassword.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func buttonClick() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dobString = df.string(from: dob)
        api.userSignUp(username: username.text!, password: password.text!, firstName: firstName, lastName: lastName, email: email.text!, status: "", dob: dobString)
        let userDefault = UserDefaults.standard
        userDefault.set(username.text!, forKey: "username")
    }
    
    @objc func textFieldDidChange(textField: UITextField) {

        if(!username.text!.isEmpty && !password.text!.isEmpty && !email.text!.isEmpty && !confirmPassword.text!.isEmpty && !confirmEmail.text!.isEmpty && password.text == confirmPassword.text && email.text == confirmEmail.text) {
            
            // Check for unique username and email
            api.isUsernameUnique(username: username.text!, completionHandler: { (success) -> Void in
                    if success {
                        print("Username is unique")
                        self.api.isEmailUnique(email: self.email.text!, completionHandler: { (success) -> Void in
                            if success {
                                print("Email is unique")
                                self.registerButton.isUserInteractionEnabled = true
                            } else {
                                print("Email is not unique")
                                self.registerButton.isUserInteractionEnabled = false
                            }
                        })
                    } else {
                        print("Username is not unique")
                        self.registerButton.isUserInteractionEnabled = false
                    }
                })
        } else {
            print("Problem with the input")
            registerButton.isUserInteractionEnabled = false
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
