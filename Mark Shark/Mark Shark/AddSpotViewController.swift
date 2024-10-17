//
//  ViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/15/24.
//

import UIKit
import CoreLocation
import MapKit

class AddSpotViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var mapType = MKMapType.satellite

    @IBOutlet weak var parking_lot_map_view: MKMapView!
    @IBOutlet weak var add_spot_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // precise accuracy needed to pinpoint parking spots
        locationManager.requestWhenInUseAuthorization()
    }
            
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()

//        parking_lot_map_view.setRegion(region, animated: animated)
        parking_lot_map_view.mapType = .satellite

        parking_lot_map_view.showsUserLocation = true
        parking_lot_map_view.userTrackingMode = .follow
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addTestAnnotation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current_location = locations.last{
            print("Coordinates: \(current_location.coordinate)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error)")
    }
    
    
    @IBAction func addSpot(_ sender: Any) {
        //print("location \(parking_lot_map_view.userLocation.coordinate)")
        let annotation = MKPointAnnotation()
        annotation.coordinate = parking_lot_map_view.userLocation.coordinate
        annotation.title = "Spot"
        annotation.subtitle = "added spot through button"
        parking_lot_map_view.addAnnotation(annotation)
        
        performSegue(withIdentifier: "spot detail segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "spot detail segue" {
            // do stuff before entering spot detail selection
        }
    }
    
    
    func addTestAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.277763, longitude: -74.007417)
        annotation.title = "Commuter Lot"
        annotation.subtitle = "test annotation"
        parking_lot_map_view.addAnnotation(annotation)
    }

}

