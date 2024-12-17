//
//  LotModel.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/24/24.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import MapKit

class lotModel {
    
    var lots:[Lot] = []

    let lotsNotification = Notification.Name(rawValue: lotNotificationKey)

    // make the class object a Singleton
    static let sharedInstance = lotModel()
        
    // method to return the singleton instance
    static func getInstance() -> lotModel {
        return sharedInstance
    }
    
    let lotDBref = Database.database().reference(withPath: "Lots")
    
    func getLots() -> [Lot] {
        return self.lots
    }

    var lotObserverHandle: UInt?
    
    func observeLots() {
        
        lotObserverHandle = lotDBref.observe(.value, with: {snapshot in
            var tempLots:[Lot] = []
            for child in snapshot.children  {
                if let data = child as? DataSnapshot {
                    if let aLot = Lot(snapshot: data) {
                        tempLots.append(aLot)
                    }
                }
            }
            self.lots.removeAll()
            self.lots = tempLots
            // need to notify
            NotificationCenter.default.post(name: self.lotsNotification, object: nil)
        })
    }
    
    func cancelObserver() {
        if let observerHandle = lotObserverHandle {
            lotDBref.removeObserver(withHandle: observerHandle)

        }
    }

    
    func addLot(lot: Lot) {
        lots.append(lot)
        let lotDBref = Database.database().reference(withPath: "Lots")
        let newLotRef = lotDBref.child(lot.lotId.uuidString)
        newLotRef.setValue(lot.toAnyObject())
    }
    
    func getLotInfo(lotId: UUID) -> Lot? {
        if let lot = lots.first(where: {$0.lotId == lotId}) {
            return lot
        } else {
            return nil
        }
    }
    

    func addSampleLots() {
        let exampleLots: [Lot] = [
            Lot(
                lotId: UUID(),
                name: "Lot #11",
                view: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 40.28341512905773, longitude: -74.00643473637345),
                    span: MKCoordinateSpan(latitudeDelta: 0.001268605385703836, longitudeDelta: 0.0010541080252295387)
                )
            ),
            Lot(
                lotId: UUID(),
                name: "Lot #14",
                view: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 40.27761483074251, longitude: -74.00755823986633),
                    span: MKCoordinateSpan(latitudeDelta: 0.0020308623555678196, longitudeDelta: 0.0016873368790015775)
                )
            ),
            Lot(
                lotId: UUID(),
                name: "Faculty Lot",
                view: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 40.28101693874187, longitude: -74.00727127915383),
                    span: MKCoordinateSpan(latitudeDelta: 0.0012686504350227779, longitudeDelta: 0.0010541080630304123)
                )
            )
        ]
        
        for lot in exampleLots {
            addLot(lot: lot)
        }
    }

    
}
