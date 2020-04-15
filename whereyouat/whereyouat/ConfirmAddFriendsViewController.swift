//
//  ConfirmAddFriendsViewController.swift
//  whereyouat
//
//  Created by Sam on 4/14/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class ConfirmAddFriendsViewController: UIViewController {

    @IBOutlet weak var friendName: UILabel!

    @IBAction func addFriend(_ sender: Any) {

        print(myUsername + friendName.text!)
        if !myUsername.isEmpty && !friendName.text!.isEmpty {
            api.addUserFriends(username1: myUsername, username2: friendName.text!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            let alert = UIAlertController(title: "", message: "\(friendName.text!) successfully added", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    var inheritedFriendName = ""
    var myUsername = ""
    var api = API.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        myUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        friendName.text = inheritedFriendName
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
