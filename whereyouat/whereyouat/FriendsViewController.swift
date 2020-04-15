//
//  FriendsViewController.swift
//  whereyouat
//
//  Created by Rachel Ma on 4/15/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate {

    var myUsername = ""
    var api = API.sharedInstance
    var friendHandler: [() -> (user)] = []
    var userFriends = [String][]
    override func viewDidLoad() {
        super.viewDidLoad()

        myUsername = UserDefaults.standard.string(forKey: "username") ?? ""
        myFriends = [String][]
        api.getUserFriends(username: myUsername)
        
        
        
        for n in 0... userFriends.count{
            api.getUser(username: myUsername, completionHandler: friendHandler)
            friendHandler.friends
        }
        

    }
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return *****.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = friendnames[indexPath.row]
        
        let friends = self.modelObjectsArray[indexPath.row] as! Person
        cell.textLabel?.text = friends.first

        
        
        
        
        
        
      return cell

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
