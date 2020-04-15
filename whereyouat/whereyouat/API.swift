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
    
    struct user: Decodable {
        var lat: Double
        var long: Double
        var first: String
        var last: String
        var email: String
        var status: String
        var dob: String
        var username: String
        var friends: [String] = [String]()
     }
    
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
    
    func loginVerify(username: String, password: String, completionHandler:@escaping (Bool) -> ()) {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(false)
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID == username) {
                        let correctPass = (document.data()["password"]) as? String ?? ""
                        if(correctPass == password) {
                            completionHandler(true)
                            return
                        }
                    }
                }
                completionHandler(false)
            }
        }
    }
    
    func getUser(username: String, completionHandler:@escaping (user) -> ())  {
        db.collection("users").document(username).getDocument{ (document, error) in
            var userData = user(lat: 0.0, long: 0.0, first: "", last: "", email: "", status: "", dob: "", username: "")
            if let document = document, document.exists {
                let data = document.data()
                userData.lat = data?["lat"] as? Double ?? 0.0
                userData.long = data?["lat"] as? Double ?? 0.0
                userData.dob = data?["dob"] as? String ?? "No birthdate data found."
                userData.first = data?["first"] as? String ?? "No first name data found."
                userData.last = data?["last"] as? String ?? "No last name data found."
                userData.email = data?["email"] as? String ?? "No email data found."
                userData.status = data?["status"] as? String ?? ""
                userData.username = data?["username"] as? String ?? ""
                print(userData)
                completionHandler(userData)
                return
            } else {
                print("No data found")
            }
        }
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
        db.collection("users").document(username).getDocument{ (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
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
    
    func updateLocation(username: String, latValue: Double, longValue: Double){
        let docRef1 = db.collection("users").document(username)
        docRef1.updateData(["lat": latValue])
        docRef1.updateData(["long": longValue])
    }
    
    
}
