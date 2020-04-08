//
//  ViewController.swift
//  whereyouat
//
//  Created by codeplus on 3/23/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var api = API.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
        if Reachability.isConnectedToNetwork(){
            print("Connected to the Internet")
            api.setup()

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


}

