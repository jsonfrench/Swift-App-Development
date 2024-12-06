//
//  Spot.swift
//  Mark Shark
//
//  Created by Jason R. French on 12/4/24.
//

import Foundation
import Firebase
import FirebaseDatabase
import MapKit

struct Spot {
    var ref: DatabaseReference?
    var number: Int
    var location: CLLocationCoordinate2D
    var isHandicapped: Bool
    var isFaculty: Bool
    var isReserved: Bool
    var spotId: UUID
        
    init (number: Int, location: CLLocationCoordinate2D, isFaculty: Bool, isHandicapped: Bool, isReserved: Bool, spotId: UUID) {
        self.ref = nil
        self.number = number
        self.location = location
        self.isFaculty = isFaculty
        self.isHandicapped = isHandicapped
        self.isReserved = isReserved
        self.spotId = spotId
    }
    
    init? (snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: Any]
        {
            guard   // might rework this
                let numberString = value["number"] as? String,
                let number = Int(numberString),
                let locationDict = value["location"] as? [String: Double],
                let latitude = locationDict["latitude"],
                let longitude = locationDict["longitude"],
                let isHandicappedString = value["isHandicapped"] as? String,
                let isHandicapped = Bool(isHandicappedString),
                let isFacultyString = value["isFaculty"] as? String,
                let isFaculty = Bool(isFacultyString),
                let isReservedString = value["isReserved"] as? String,
                let isReserved = Bool(isReservedString),
                let spotIdString = value["spotId"] as? String,
                let spotId = UUID(uuidString: spotIdString)
            else {
                return nil
            }
            
            self.ref = snapshot.ref
            self.number = number
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.isHandicapped = isHandicapped
            self.isReserved = isReserved
            self.isFaculty = isFaculty
            self.spotId = spotId
        } else {
            return nil
        }
        
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "number": String(self.number),
            "location": [
                "latitude": self.location.latitude,
                "longitude": self.location.longitude
            ],
            "isHandicapped": String(self.isHandicapped),
            "isFaculty": String(self.isFaculty),
            "isReserved": String(self.isReserved),
            "spotId": self.spotId.uuidString
        ]
    }
    
}
