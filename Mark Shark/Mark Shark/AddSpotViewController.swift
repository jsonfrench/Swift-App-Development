//
//  ViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/15/24.
//

import UIKit
import CoreLocation
import MapKit

class AddSpotViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    // Set up constants, outlets, classes here //
    
    let locationManager = CLLocationManager()
    var mapType = MKMapType.satellite
    @IBOutlet var map_tap_gesture: UITapGestureRecognizer!
    
    // parking lot location:
    // 40.2776, -74.007417

    @IBOutlet weak var parking_lot_map_view: MKMapView!
    @IBOutlet weak var add_spot_button: UIButton!
    
    // Manage view loading, appearing, dissapearing //
    
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

        parking_lot_map_view.mapType = .satellite
        parking_lot_map_view.showsUserLocation = true
//        parking_lot_map_view.userTrackingMode = .follow
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTestAnnotation()
    }
    
    // Manage location functions, updates //
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current_location = locations.last{
            print("Coordinates: \(current_location.coordinate)")

            // snap camera to user's current location
            let center = CLLocationCoordinate2D(latitude: current_location.coordinate.latitude, longitude: current_location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
            parking_lot_map_view.setRegion(region, animated: true)

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error)")
    }
    
    // UI Management //
    
    // press "Add Spot" button
    @IBAction func addSpot(_ sender: Any) {
        //print("location \(parking_lot_map_view.userLocation.coordinate)")
        let annotation = MKPointAnnotation()
        annotation.coordinate = parking_lot_map_view.userLocation.coordinate
        annotation.title = "Spot"
        annotation.subtitle = "added spot through button"
        parking_lot_map_view.addAnnotation(annotation)
        
        performSegue(withIdentifier: "spot detail segue", sender: self)
    }
    
    // manage segue to other view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "spot detail segue" {
            let destinationViewController = segue.destination as! SpotAttributesTableViewController
            destinationViewController.coordinate = parking_lot_map_view.userLocation.coordinate
            destinationViewController.annotation_title = "parking spot"
            destinationViewController.annotation_subtitle = "parking spot subtitle"
        }
    }
    
    
    // add annotation functions //
    
    func addNewAnnotation(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        parking_lot_map_view.addAnnotation(annotation)
    }
    
    func addTestAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.277763, longitude: -74.007417)
        annotation.title = "Commuter Lot"
        annotation.subtitle = "test annotation"
        parking_lot_map_view.addAnnotation(annotation)
    }
    var x = 0
    //add annotation with tap
    @IBAction func didTapMap(_ sender: UITapGestureRecognizer) {
        
        let tap_location = sender.location(in: view)
        let map_location = parking_lot_map_view.convert(tap_location, toCoordinateFrom: parking_lot_map_view)

        print("tap \(x) at \(tap_location) -> \(map_location)")
        x+=1
        
        addNewAnnotation(coordinate: map_location, title: "Spot #", subtitle: "lot #")
    }

}

