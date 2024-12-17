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

    let spotDBref = Database.database().reference(withPath: "Spots")
    var spotObserverHandle: UInt?
    let spotsNotification = Notification.Name(rawValue: lotNotificationKey)

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
    
    func observeSpots() {
        
        spotObserverHandle = spotDBref.observe(.value, with: {snapshot in
            var tempSpots:[Spot] = []
            for child in snapshot.children  {
                if let data = child as? DataSnapshot {
                    if let aSpot = Spot(snapshot: data) {
                        tempSpots.append(aSpot)
                    }
                   
                }
            }
            self.spots.removeAll()
            self.spots = tempSpots
            // need to notify
            NotificationCenter.default.post(name: self.spotsNotification, object: nil)
        })
    }
    
    func cancelObserver() {
        if let observerHandle = spotObserverHandle {
            spotDBref.removeObserver(withHandle: observerHandle)
        }
    }

    
    func getSpots() -> [Spot] {
        return self.spots
    }

    func addSpot(spot: Spot, lot: Lot){
        let spot_ref = Database.database().reference(withPath: "Spots")
        let new_spot_ref = spot_ref.child(spot.spotId.uuidString)
        new_spot_ref.setValue (spot.toAnyObject())
    }
    
    func deleteSpot (spot: Spot) {
        let spotDBref = Database.database().reference(withPath: "Spots")
        let newSpotRef = spotDBref.child(spot.spotId.uuidString)
        newSpotRef.removeValue()
    }
 
    func getSpotInfo(spotId: UUID) -> Spot? {
        if let spot = spots.first(where: {$0.spotId == spotId}) {
            return spot
        } else {
            return nil
        }
    }

}
