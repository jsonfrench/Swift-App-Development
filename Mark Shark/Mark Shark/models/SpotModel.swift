//
//  spotModel.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/25/24.
//

import Foundation
import MapKit

struct spot
{
    var number: Int
    var location: CLLocationCoordinate2D
    var isHandicapped: Bool
    var isFaculty: Bool
    var isReserved: Bool
    var spotId: UUID
}

class spotModel {
    
    var spots:[spot] = []
    
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
    }
 
    func getSpotInfo(spotId: UUID) -> spot? {
        if let spot = spots.first(where: {$0.spotId == spotId}) {
            return spot
        } else {
            return nil
        }
    }

}
