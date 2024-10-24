//
//  AddLotViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/24/24.
//

import UIKit
import MapKit
import CoreLocation

class AddLotViewController: UIViewController, CLLocationManagerDelegate {
    
    // set up outlets and constants //
    
    @IBOutlet weak var map_view: MKMapView!
    @IBOutlet weak var done_button: UIBarButtonItem!
    @IBOutlet weak var lot_name_field: UITextField!
    
    let locationManager = CLLocationManager()
    var lot_table: SelectLotTableViewController?

    // View management //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        done_button.isEnabled = false

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // precise accuracy needed to pinpoint parking spots
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.startUpdatingLocation()
        map_view.mapType = .satellite
        map_view.showsUserLocation = true
        //        parking_lot_map_view.userTrackingMode = .follow.
    }

    // Map View Management //

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let current_location = locations.last{
            print("Coordinates: \(current_location.coordinate)")

            // snap camera to user's current location
            let center = CLLocationCoordinate2D(latitude: current_location.coordinate.latitude, longitude: current_location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
            map_view.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error)")
    }

    @IBAction func didReturn(_ sender: Any) {
        lot_name_field.resignFirstResponder()
        done_button.isEnabled = true    // <- placeholder until i implement and observer for the text field
    }
    
    @IBAction func didSelectDone(_ sender: Any) {
        let lot_name = lot_name_field.text
        lot_table!.addLot(name: lot_name!)
        navigationController?.popViewController(animated: true)
    }
    
}


    

    // to do
    
    // edit name of lot
    // on done, add new lot information to lots model
    
    // "done" starts off inactive
    // "done" switches to active if lot name is entered - observer pattern?
    
    // display coordinates? - enter coordinates as text?
    // center coordinates or MKRegion?

    // add objserver to tell when text has been entered to enable "done"
    
