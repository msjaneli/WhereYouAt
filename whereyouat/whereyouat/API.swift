//
//  API.swift
//  whereyouat
//
//  Created by codeplus on 3/30/20.
//  Copyright © 2020 CS290. All rights reserved.
//
import CoreLocation

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

var db: Firestore!

class API {
    
    static let sharedInstance = API()
    
    func setup(){
    // [START setup]
    let settings = FirestoreSettings()

    FirebaseApp.configure()
    Firestore.firestore().settings = settings
    // [END setup]
    db = Firestore.firestore()
    }
    
    func userSignUp(username: String, password: String, firstName: String, lastName: String, email: String, status: String, dob: String){
        // [START add_ada_lovelace]
                     // Add a new document with a generated ID
        print(username, password, firstName, lastName, email, status, dob)
        db.collection("users").document(username).setData([
                         "username": username,
                         "password": password,
                         "first": firstName,
                         "last": lastName,
                         "email": email,
                         "status": status,
                         "dob": dob,
                         "friends": []
                     ])
    }
    
    func getUsers() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func setStatus(username: String, status: String) {
        db.collection("users").document(username).updateData(["status": status])
    }
    
    func getUserFriends(username: String){
        let docRef = db.collection("users").document(username)
        docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
    }
    }
    
    func addUserFriends(username1: String, username2: String){
        let docRef1 = db.collection("users").document(username1)
        docRef1.updateData([
            "friends":FieldValue.arrayUnion([username2])])
        
        let docRef2 = db.collection("users").document(username2)
        docRef2.updateData([
            "friends":FieldValue.arrayUnion([username1])])
    }
    
    func createEvent(){
        db.collection("allEvents").document("janeli").collection("userEvents").addDocument(data: [
            "title": "Sam's Birthday Party",
            "date": NSDate(timeInterval: 43, since: NSDate(timeIntervalSinceReferenceDate: 34) as Date),
            "rsvp": []
        ])
    }
    
    func updateLocation(username: String, locValue: CLLocationCoordinate2D){
        let docRef1 = db.collection("users").document(username)
        docRef1.updateData(["location": locValue])
    }
    
    
}
