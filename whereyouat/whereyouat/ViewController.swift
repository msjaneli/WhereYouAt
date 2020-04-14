//
//  ViewController.swift
//  whereyouat
//
//  Created by codeplus on 3/23/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var api = API.sharedInstance
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        if Reachability.isConnectedToNetwork(){
            print("Connected to the Internet")
            api.setup()
            username.delegate = self
            password.delegate = self
            loginButton.isUserInteractionEnabled = false
            loginButton.addTarget(self, action:#selector(buttonClick), for: .touchUpInside)
         }
         else{
             print("No Connnection to Internet")
             let alert = UIAlertController(title:"Internet offline", message: "Please check your connection and try again.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
             NSLog("The \"OK\" alert occured.")
             }))
             self.present(alert, animated: true, completion: nil)
         }
        
    }
    
    @objc func buttonClick() {
        let userDefault = UserDefaults.standard
        userDefault.set(username.text!, forKey: "username")
     }
     
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
         if(!username.text!.isEmpty && !password.text!.isEmpty) {
            api.loginVerify(username: username.text!, password: password.text!, completionHandler: { (success) -> Void in
                if success {
                    print("Login Successful")
                    self.loginButton.isUserInteractionEnabled = true
                } else {
                    print("Login failed (incorrect username/password combination")
                    self.loginButton.isUserInteractionEnabled = false
                }
            })

         } else {
             loginButton.isUserInteractionEnabled = false
         }
         return true
         
     }


}

