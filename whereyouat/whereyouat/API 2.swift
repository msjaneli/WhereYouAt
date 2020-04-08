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
    
    func setup(){
    // [START setup]
    let settings = FirestoreSettings()

    Firestore.firestore().settings = settings
    // [END setup]
    db = Firestore.firestore()
    }
    
    func userSignUp(){
        // [START add_ada_lovelace]
                     // Add a new document with a generated ID
        db.collection("users").document("samchan").setData([
                         "username": "samchan",
                         "password": "hello12345",
                         "first": "Sam",
                         "last": "Chan",
                         "email":"samchan@duke.edu",
                         "status": "",
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
    
    func setStatus() {
        db.collection("users").document("samchan").updateData(["status": "balling"])
    }
    
    func getUserFriends(){
        let docRef = db.collection("users").document("janeli")
        docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
    }
    }
    
    func addUserFriends(){
        let docRef1 = db.collection("users").document("janeli")
        docRef1.updateData([
            "friends":FieldValue.arrayUnion(["samchan"])])
        
        let docRef2 = db.collection("users").document("samchab")
        docRef2.updateData([
            "friends":FieldValue.arrayUnion(["janeli"])])
    }
    
    func createEvent(){
        db.collection("allEvents").document("janeli").collection("userEvents").addDocument(data: [
            "title": "Sam's Birthday Party",
            "date": NSDate(timeInterval: 43, since: NSDate(timeIntervalSinceReferenceDate: 34) as Date),
            "rsvp": []
        ])
    }
    
    func updateLocation(locValue: CLLocationCoordinate2D){
        let docRef1 = db.collection("users").document("janeli")
        docRef1.updateData(["location": locValue])
    }
    
    
}
