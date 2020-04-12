//
//  mapViewController.swift
//  whereyouat
//
//  Created by Neha Kota on 3/30/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var guideButton: UIButton!
    
    @IBOutlet weak var addFriendsButton: UIButton!
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var freeButton: UIButton!
    @IBOutlet weak var studyingButton: UIButton!
    @IBOutlet weak var busyButton: UIButton!
    
    var api = API.sharedInstance

    let locationManager = CLLocationManager()
    
    var myStatus = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.guideButton.layer.cornerRadius = 15
                
        self.freeButton.layer.cornerRadius = 0.5 * freeButton.bounds.size.width
              
        self.studyingButton.layer.cornerRadius = 0.5 * studyingButton.bounds.size.width
              
        self.busyButton.layer.cornerRadius = 0.5 * busyButton.bounds.size.width
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            myMap.showsUserLocation = true
            myMap.showsBuildings = true
        }
        
          getStatus()
          updateMyMarker()
        
        
    }
    
   // MARK: - CoreLocation Delegate Methods
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // Get most recent CLLocation from array
    // let userLocation:CLLocation = locations[0] as CLLocation
    if let userLocation = locations.first {
        print("latitude = \(userLocation.coordinate.latitude)")
        print("longitude = \(userLocation.coordinate.longitude)")
        

        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

        let region = MKCoordinateRegion(center: myLocation, span: span)
        myMap.setRegion(region, animated: true)

        let myUsername = UserDefaults.standard.string(forKey: "username") ?? nil
               if((myUsername) != nil){
                api.updateLocation(username: myUsername!, latValue: userLocation.coordinate.latitude, longValue: userLocation.coordinate.longitude)
        }
    }
    
    
    // Call stopUpdatingLocation() to stop listening for location updates,
    // otherwise this function will be called every time when user location changes.
    // locationManager.stopUpdatingLocation()
    
   }
   
   
   // catch any location errors
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
   {
       print("Error \(error)")
   }
   
   // catch any changes to user authorization (setting page change for example)
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedAlways {
               print("App is still authorized")
   //            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
   //                if CLLocationManager.isRangingAvailable() {
   //
   //                }
   //            }
           } else {
               print("App is not authorized")
           }
       }
   

    @IBAction func setFreeStatus(_ sender: Any) {
        myStatus = "free"
        setStatus(status: myStatus)
        print(self.myStatus)
    }
    @IBAction func setStudyingStatus(_ sender: Any) {
        myStatus="studying"
        setStatus(status: myStatus)
        print(self.myStatus)
    }
    @IBAction func setBusyStatus(_ sender: Any) {
        myStatus="busy"
        setStatus(status: myStatus)
        print(self.myStatus)
    }
    
    func setStatus(status: String) {
        let myUsername = UserDefaults.standard.string(forKey: "username") ?? nil
        if((myUsername) != nil){
            api.setStatus(username: myUsername!, status: status)
            updateMyMarker()
        }
        else {
            print("Error in setting status.")
        }
    }
    
    func getStatus(){
        let myUsername = UserDefaults.standard.string(forKey: "username") ?? nil
        if((myUsername) != nil){
            self.myStatus = api.getStatus(username: myUsername!)
        }
    }
    
    func updateMyMarker() {
        switch(myStatus){
            case "free":
                myMap.tintColor = UIColor(red: 151.0/255.0, green: 237.0/255.0, blue: 147.0/255.0, alpha: 1.0)
            case "studying":
                myMap.tintColor = UIColor(red: 255.0/255.0, green: 249.0/255.0, blue: 157.0/255.0, alpha: 1.0)
            case "busy":
                myMap.tintColor = UIColor(red: 255.0/255.0, green: 111.0/255.0, blue: 88.0/255.0, alpha: 1.0)
            default:
                myMap.tintColor = UIColor.blue
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
