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
    @IBOutlet weak var lot_region_background: UIView!
    @IBOutlet var tap_recognizer: UITapGestureRecognizer!
    
    let locationManager = CLLocationManager()
    var lot_table: SelectLotTableViewController?
    let lot_model = lotModel.getInstance()
    

    // View management //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        done_button.isEnabled = false
        lot_name_field.addTarget(self, action: #selector(didEnterName), for: .editingChanged)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // precise accuracy needed to pinpoint parking spots
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lot_region_background.layer.cornerRadius = 5

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

    @objc func didEnterName(){
        done_button.isEnabled = true
    }
    
    // Close out the keyboard //
    
    @IBAction func didReturn(_ sender: Any) {
        lot_name_field.endEditing(true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        lot_name_field.endEditing(true)
    }

    @IBAction func didSelectDone(_ sender: Any) {
        
        print("got to function!")
        
        let new_lot = Lot(
            lotId: UUID(),
            name: lot_name_field.text!,
            view: map_view.region
            )
        
        print("made lot!")
        
        lot_model.addLot(lot: new_lot)
        
        print("called add_lot!")
        
        navigationController?.popViewController(animated: true)
    }
    
}
