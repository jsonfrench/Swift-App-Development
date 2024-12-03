//
//  spotModel.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/25/24.
//

import Foundation
import MapKit
import Firebase
import FirebaseDatabase


struct spot
{
    var number: Int
    var location: CLLocationCoordinate2D
    var isHandicapped: Bool
    var isFaculty: Bool
    var isReserved: Bool
    var spotId: UUID
    
    func toAnyObject () -> Dictionary<String, Any> {
        return [
            "number": self.number,
            "location" : self.location,
            "isHandicapped": self.isHandicapped,
            "isFaculty": self.isFaculty,
            "isReserved": self.isReserved,
            "spotId": self.spotId
        ]
    }

}

class spotModel {
    
    var spots:[spot] = []

    var spot_ref = Database.database().reference(withPath: "Spot")
    
    // showAlert(td: "ToDo Posted")
    
    // commuter lot location:
    // 40.2776, -74.007417

    // make the class object a Singleton
    static let sharedInstance = spotModel()
        
    // method to return the singleton instance
    static func getInstance() -> spotModel {
        return sharedInstance
    }
    
    // constructor
    private init() {
        // do something on initialization
    }
    
    func getSpots() -> [spot] {
        return self.spots
    }
    
    func addSpot(number:Int, location:CLLocationCoordinate2D, isHandicapped: Bool, isFaculty: Bool, isReserved: Bool, spotId: UUID) {
        let new_spot = spot(number: number, location: location, isHandicapped: isHandicapped, isFaculty: isFaculty, isReserved: isReserved, spotId: spotId)
        spots.append(new_spot)
        // showAlert(td: "ToDo Posted")
    }
    
    func addSpot(spot: spot){
        let spot_ref = Database.database().reference(withPath: "Spots")
        let new_spot_ref = spot_ref.child(spot.spotId.description)
        new_spot_ref.setValue (spot.toAnyObject())
    }
 
    func getSpotInfo(spotId: UUID) -> spot? {
        if let spot = spots.first(where: {$0.spotId == spotId}) {
            return spot
        } else {
            return nil
        }
    }

}
