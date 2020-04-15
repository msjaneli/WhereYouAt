//
//  FriendsViewController.swift
//  whereyouat
//
//  Created by Rachel Ma on 4/15/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var friendsTable: UITableView!
    
    var myUsername = ""
    var api = API.sharedInstance
   // var friendHandler: [() -> (user)] = []
    var userFriends: [String] = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        myUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        
        api.getUser(username: myUsername, completionHandler: { (user) -> Void in
            self.userFriends = user.friends
            DispatchQueue.main.async {
                self.friendsTable.reloadData()
            }
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = self.userFriends[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Arial Rounded MT Bold", size:17)
        cell.textLabel?.textColor = UIColor.orange
      return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        api.removeUserFriends(username1: myUsername, username2: userFriends[indexPath.row])
        userFriends.remove(at: indexPath.row)
        friendsTable.deleteRows(at: [indexPath], with: .fade)
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
