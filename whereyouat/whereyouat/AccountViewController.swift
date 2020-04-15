//
//  AccountViewController.swift
//  whereyouat
//
//  Created by Sam on 4/14/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    var myUsername = ""
    var api = API.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        myUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        api.getUser(username: myUsername, completionHandler: { (user) -> Void in
            print(user)
            self.fullName.text = user.first + " " + user.last
            self.username.text = user.username
            //self.image = user.image
            self.email.text = user.email
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if (user.dob != "" && user.dob != "No birthdate data found."){
                let date = dateFormatter.date(from:user.dob)!
            
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .short
                 
                let dateString = formatter.string(from: date)
            
                self.birthdate.text = dateString
            }
        })

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "username")
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
