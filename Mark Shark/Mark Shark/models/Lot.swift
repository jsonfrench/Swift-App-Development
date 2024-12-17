//
//  Lot.swift
//  Mark Shark
//
//  Created by Jason R. French on 12/4/24.
//

import Foundation
import Firebase
import FirebaseDatabase
import MapKit

struct Lot {
    var ref: DatabaseReference?
    var lotId: UUID
    var name:String
    var view: MKCoordinateRegion
        
    init(lotId: UUID, name: String, view: MKCoordinateRegion) {
        self.ref = nil
        self.lotId = lotId
        self.name = name
        self.view = view
    }
    
    init? (snapshot: DataSnapshot) {
        
        if let value = snapshot.value as? [String: Any]
        {
            guard
                let lotIdString = value["lotId"] as? String,
                let lotId = UUID(uuidString: lotIdString),
                let name = value["name"] as? String,
                let view = value["view"] as? [String: Any],
                let latitude = view["latitude"] as? Double,
                let longitude = view["longitude"] as? Double,
                let latitudeDelta = view["latitudeDelta"] as? Double,
                let longitudeDelta = view["longitudeDelta"] as? Double
            else {
                return nil
            }
            
            self.ref = snapshot.ref
            self.lotId = lotId
            self.name = name
            self.view = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                latitudinalMeters: latitudeDelta,
                longitudinalMeters: longitudeDelta
            )
        } else {
            return nil
        }
    }
    
    func toAnyObject () -> Dictionary<String, Any> {
        return [
            "lotId": self.lotId.uuidString,
            "name": self.name,
            "view": [
                "latitude": self.view.center.latitude,
                "longitude": self.view.center.longitude,
                "latitudeDelta": self.view.span.latitudeDelta,
                "longitudeDelta": self.view.span.longitudeDelta
            ]
        ]
    }
    
}
