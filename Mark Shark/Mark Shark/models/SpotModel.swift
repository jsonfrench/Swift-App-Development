//
//  spotModel.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/25/24.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import MapKit

class spotModel {
    
    var spots:[Spot] = []
    
    // showAlert(td: "ToDo Posted")
    
    // commuter spot location:
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
    
    func getSpots() -> [Spot] {
        return self.spots
    }

    func addSpot(spot: Spot, lot: Lot){
        let path = lot.lotId.uuidString
        let spot_ref = Database.database().reference(withPath: "Lots/\(path)/Spots")
        let new_spot_ref = spot_ref.child(spot.spotId.uuidString)
        new_spot_ref.setValue (spot.toAnyObject())
    }
 
    func getSpotInfo(spotId: UUID) -> Spot? {
        if let spot = spots.first(where: {$0.spotId == spotId}) {
            return spot
        } else {
            return nil
        }
    }

}
