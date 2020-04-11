//
//  AddFriendsViewController.swift
//  whereyouat
//
//  Created by Akshara Anand on 4/11/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class AddFriendsViewController: UIViewController, UITextFieldDelegate {
    
    //enteredFriendName is the UITextField for the friend trying to be added
    @IBOutlet weak var enteredFriendName: UITextField!
    // this sets the FriendUsername for the next screen
    @IBOutlet weak var setFriendUsername: UIButton!
    // this completes the task of adding friends by calling api.addUserFriends function on the button click
    @IBOutlet weak var addFriendsButton: UIButton!
    // this is the displayed username on the second screen
    @IBOutlet weak var friendUsername: UILabel!
    // changes the friendUsername to the input from the UITextField
    @IBAction func onFirstButtonClicked(_ sender: Any) {
        friendUsername.text = " \(enteredFriendName.text!)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enteredFriendName.delegate = self

        // Do any additional setup after loading the view.
    }
    //when clicking on add friends image on second screen, call addUserFriends
    var api = API.sharedInstance
    let userDefault = UserDefaults.standard
    @IBAction func onSecondButtonClicked(_ sender: Any) {
        api.addUserFriends(username1: userDefault.text!, username2: friendUsername.text!)
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
