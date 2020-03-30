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
    @IBOutlet weak var inputStatusButton: UIButton!
    
    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputStatusButton.layer.cornerRadius = 20
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            myMap.showsUserLocation = true
        }
    }
    
   // MARK: - CoreLocation Delegate Methods
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // Get most recent CLLocation from array
    // let userLocation:CLLocation = locations[0] as CLLocation
    if let userLocation = locations.first {
        print("latitude = \(userLocation.coordinate.latitude)")
        print("longitude = \(userLocation.coordinate.longitude)")
        
        let myLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
               let region = MKCoordinateRegion(center: myLocation, span: span)
               myMap.setRegion(region, animated: true)

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
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
