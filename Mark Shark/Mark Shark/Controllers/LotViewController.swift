//
//  LotViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 12/16/24.
//

import UIKit
import CoreLocation
import MapKit

class LotViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Set up constants, outlets, classes here //
    
    let lot_model = lotModel.sharedInstance
    var selected_lot_id: UUID?
    var selected_lot: Lot?

    let spot_model = spotModel.sharedInstance
//    var spots: [Spot] = []

    let locationManager = CLLocationManager()
    var mapType = MKMapType.satellite
    

    @IBOutlet weak var parking_lot_map_view: MKMapView!
    
    // Manage view loading, appearing, dissapearing //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // precise accuracy needed to pinpoint parking spots
        locationManager.requestWhenInUseAuthorization()
        parking_lot_map_view.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spot_model.observeSpots()
        
        locationManager.startUpdatingLocation()
        parking_lot_map_view.mapType = .satellite
        
        if let lot_id = selected_lot_id {
            selected_lot = lot_model.getLotInfo(lotId: lot_id)
            if (selected_lot != nil) {
                self.title = selected_lot?.name
                parking_lot_map_view.setRegion(selected_lot!.view, animated: true)
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for spot in spot_model.spots{
            let annotation = MKPointAnnotation()
            annotation.coordinate = spot.location
            annotation.title = String(spot.number)
            annotation.subtitle = spot.spotId.uuidString
            parking_lot_map_view.addAnnotation(annotation)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            let identifier = "parking spot marker"
            
            var annotation_view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotation_view == nil {
                annotation_view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //            annotation_view?.image = UIImage(systemName: "mappin.circle.fill") // Use your custom image
                annotation_view?.canShowCallout = true
            } else {
                annotation_view?.annotation = annotation
            }
            
            return annotation_view
        }
        
        // Manage location functions, updates //
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
            print("Error: \(error)")
        }
    }
}
