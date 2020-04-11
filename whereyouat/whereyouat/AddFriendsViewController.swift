//
//  AddFriendsViewController.swift
//  whereyouat
//
//  Created by Akshara Anand on 4/11/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class AddFriendsViewController: UIViewController, UITextFieldDelegate {
    
    // IBOutlet weak var friendUsername: UITextField!
    
    // IBOutlet weak var addButton: UIButton!
    
    
//    @IBOutlet weak var friendUsername: UITextField!
    @IBOutlet weak var enteredFriendName: UITextField!
    @IBOutlet weak var setFriendUsername: UIButton!
    @IBOutlet weak var addFriendsButton: UIButton!
    @IBOutlet weak var friendUsername: UILabel!
    friendUsername.text = enteredFriendName.text
    
    @IBAction func onFirstButtonClicked(_ sender: Any) {
        friendUsername.text = " \(enteredFriendName.text!)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enteredFriendName.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // @objc func buttonClick()
    // api.addUserFriends(username1: username, username2: friendUsername)
    

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
