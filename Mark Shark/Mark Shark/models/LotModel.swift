//
//  LotModel.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/24/24.
//

import Foundation
import MapKit

struct lot
{
    var name:String
    var view: MKCoordinateRegion
    var lotId: Int
}

class lotModel {
    
//    var lots:[lot] = []

    // add some example lots
    var lots:[lot] = [
        lot(name: "Lot #11", view: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.28341512905773, longitude: -74.00643473637345), span: MKCoordinateSpan(latitudeDelta: 0.001268605385703836, longitudeDelta: 0.0010541080252295387)), lotId: 0),
        lot(name: "Lot #14", view: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.27761483074251, longitude: -74.00755823986633), span: MKCoordinateSpan(latitudeDelta: 0.0020308623555678196, longitudeDelta: 0.0016873368790015775)), lotId: 0),
        lot(name: "Faculty Lot", view: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.28101693874187, longitude: -74.00727127915383), span: MKCoordinateSpan(latitudeDelta: 0.0012686504350227779, longitudeDelta: 0.0010541080630304123)), lotId: 2)
    ]


    // make the class object a Singleton
    static let sharedInstance = lotModel()
        
    // method to return the singleton instance
    static func getInstance() -> lotModel {
        return sharedInstance
    }
    
    // constructor
    private init() {
        // do something on initialization
    }
    
    func getLots() -> [lot] {
        return self.lots
    }
    
    func addLot(name:String, view:MKCoordinateRegion, lotId: Int) {
        let new_lot = lot(name: name, view: view, lotId: lotId)
        lots.append(new_lot)
    }
 
    func getLotInfo(lotId: Int) -> lot? {
        if let lot = lots.first(where: {$0.lotId == lotId}) {
            return lot
        } else {
            return nil
        }
    }

}
