//
//  ViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/15/24.
//

import UIKit
import CoreLocation
import MapKit

class AddSpotViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    // Set up constants, outlets, classes here //

    let lot_model = lotModel.getInstance()
    var selected_lot_id: UUID?
    var selected_lot: Lot?
    
    let spot_model = spotModel.getInstance()

    let locationManager = CLLocationManager()
    var mapType = MKMapType.satellite
    
    var placedAnnotation = false
    
    @IBOutlet var tap_gesture_recognizer: UITapGestureRecognizer!
    @IBOutlet weak var parking_lot_map_view: MKMapView!
    
    // switches
    @IBOutlet weak var handicapped_switch: UISwitch!
    @IBOutlet weak var faculty_switch: UISwitch!
    @IBOutlet weak var reserved_switch: UISwitch!
    @IBOutlet weak var spot_number_field: UITextField!
    @IBOutlet weak var add_spot_button: UIButton!

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

        locationManager.startUpdatingLocation()
        parking_lot_map_view.mapType = .satellite
        
        if let lot_id = selected_lot_id {
            selected_lot = lot_model.getLotInfo(lotId: lot_id)
            if (selected_lot != nil) {
                self.title = selected_lot?.name
                parking_lot_map_view.setRegion(selected_lot!.view, animated: true)
            }
        }
        view.bringSubviewToFront(add_spot_button) // <- this won't work for some reason
        view.sendSubviewToBack(parking_lot_map_view)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.bringSubviewToFront(add_spot_button)
//        addTestAnnotation()
    }
        
    // Custom Marker Setup //

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "CustomMarker"
//
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView?.image = UIImage(systemName: "mappin.circle.fill") // Use your custom image
//            annotationView?.canShowCallout = true
//            annotationView?.isDraggable = true // Enable dragging
//            annotationView?.centerOffset = CGPoint(x: 0, y: -annotationView!.frame.height / 2) // Adjust the pin position
//        } else {
//            annotationView?.annotation = annotation
//        }
//
//        return annotationView
//    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let identifier = "parking spot marker"
        
        var annotation_view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotation_view == nil {
            annotation_view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotation_view?.image = UIImage(systemName: "mappin.circle.fill") // Use your custom image
            annotation_view?.canShowCallout = true
            annotation_view?.isDraggable = true
        } else {
            annotation_view?.annotation = annotation
        }
        
        return annotation_view
    }

    func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
                
        switch newState {
        case .starting:
            annotationView.transform = CGAffineTransform(scaleX: 1.1, y: 0)
        case .dragging:
            annotationView.transform = CGAffineTransform(scaleX: 1.1, y: 0)
            print(
                "dragging"
            )
        case .ending, .canceling:
            print("dropped")
            annotationView.transform = .identity
            if let annotation = annotationView.annotation {
                print("New location: \(annotation.coordinate)")
            }
            annotationView.dragState = .none
        default:
            break
        }
        
    }

    // Manage location functions, updates //
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error: \(error)")
    }
    
    // add annotation functions //
    
    func addNewAnnotation(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        parking_lot_map_view.addAnnotation(annotation)
                
//        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "parking spot marker")
        
        placedAnnotation = true
    }
    
    func addTestAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 40.277763, longitude: -74.007417)
        annotation.title = "Commuter Lot"
        annotation.subtitle = "test annotation"
        parking_lot_map_view.addAnnotation(annotation)
    }

    //add annotation with tap
    @IBAction func userDidTap(_ sender: UITapGestureRecognizer) {
        
        dismiss_keyboard(self)
        
        if !placedAnnotation {
            let tap_location = sender.location(in: parking_lot_map_view)
            let map_location = parking_lot_map_view.convert(tap_location, toCoordinateFrom: parking_lot_map_view)
                        
            addNewAnnotation(coordinate: map_location, title: "Spot #", subtitle: "lot #")
            
            add_spot_button.isEnabled = true
        }
    }
    
    @IBAction func dismiss_keyboard(_ sender: Any) {
        spot_number_field.endEditing(true)
    }
    
    @IBAction func add_spot(_ sender: Any) {

        let new_spot_marker = parking_lot_map_view.annotations.last

        parking_lot_map_view.removeAnnotations(parking_lot_map_view.annotations) // clear new spot marker
        
        let new_spot = Spot(
            number: Int(spot_number_field.text!) ?? 0,
            location: new_spot_marker?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), // <- unwrapping an optional doesn't seem to work with structs
            isFaculty: faculty_switch.isOn,
            isHandicapped: handicapped_switch.isOn,
            isReserved: reserved_switch.isOn,
            spotId: UUID.init(),
            lotId: selected_lot_id!
        )
        
        spot_model.addSpot(spot: new_spot, lot: selected_lot!)
        
        reset_settings()
    }
    
    func reset_settings(){
        handicapped_switch.isOn = false
        faculty_switch.isOn = false
        reserved_switch.isOn = false
        spot_number_field.text = ""
        add_spot_button.isEnabled = false

        placedAnnotation = false
    }
    

}
