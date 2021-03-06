//
//  statusViewController.swift
//  whereyouat
//
//  Created by Neha Kota on 3/30/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class statusViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var guideButton: UIButton!
    
    @IBOutlet weak var addFriendsButton: UIButton!
    
    //free button
    @IBOutlet weak var freeButton: UIButton!
    
    @IBAction func freeButton(_ sender: UIButton) {
        self.myStatus = "free"
        updateStatus(status:self.myStatus)
        //print("Current Status: "+self.myStatus)
    }
    
    //studying button
    @IBOutlet weak var studyingButton: UIButton!
    
    @IBAction func studyingButton(_ sender: UIButton) {
        self.myStatus = "studying"
        updateStatus(status:self.myStatus)
        //print("Current Status: "+self.myStatus)
    }
    
    //busy button
    @IBOutlet weak var busyButton: UIButton!
    
    @IBAction func busyButton(_ sender: UIButton) {
        self.myStatus = "busy"
        updateStatus(status:self.myStatus)
        //print("Current Status: "+self.myStatus)
    }
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var myStatus = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.freeButton.layer.cornerRadius = 0.5 * freeButton.bounds.size.width
        
        self.studyingButton.layer.cornerRadius = 0.5 * studyingButton.bounds.size.width
        
        self.busyButton.layer.cornerRadius = 0.5 * busyButton.bounds.size.width
        
        self.guideButton.layer.cornerRadius = 15
        
        self.addFriendsButton.layer.cornerRadius = 15
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        
        
    }
    
    func updateStatus(status: String){
        switch(myStatus){
                   case "free":
                       myMap.tintColor = UIColor.green
                   case "studying":
                       myMap.tintColor = UIColor.yellow
                   case "busy":
                       myMap.tintColor = UIColor.red
                   default:
                       myMap.tintColor = UIColor.blue
               }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // Get most recent CLLocation from array
       // let userLocation:CLLocation = locations[0] as CLLocation
       if let userLocation = locations.first {
           //print("latitude = \(userLocation.coordinate.latitude)")
           //print("longitude = \(userLocation.coordinate.longitude)")
           
           let myLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
           
           let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                  let region = MKCoordinateRegion(center: myLocation, span: span)
                  myMap.setRegion(region, animated: true)

       }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! mapViewController
        destVC.myStatus = self.myStatus
    }
    

}
