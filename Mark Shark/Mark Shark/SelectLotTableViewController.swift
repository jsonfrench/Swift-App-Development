//
//  ViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/17/24.
//

import UIKit
import MapKit

class SelectLotTableViewController: UITableViewController {
    
    // set up constants, outlets //
    @IBOutlet weak var add_lot_button: UIBarButtonItem!
        
    var coordinate: CLLocationCoordinate2D?
    var annotation_title: String?
    var annotation_subtitle: String?
    
    let number_of_sections = 1
    let cell_height: CGFloat = 50
    let cell_reuse_identifier = "lot number"
    
    let lot_model = lotModel.getInstance()
    var selected_lot_id: Int?
    var lots: [lot] = []

    // Manage view loading, dissapearing, appearing... //

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("table view loaded!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lots = lot_model.getLots()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // Handle Table Actions and Rendering //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return number_of_sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_identifier, for: indexPath) as! SelectLotViewCell
        cell.option_title.text = self.lots[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_lot_id = lots[indexPath.row].lotId
        performSegue(withIdentifier: "add spot segue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "add spot segue") {
            let destinationViewController = segue.destination as! AddSpotViewController
            destinationViewController.selected_lot_id = selected_lot_id
        }
        if (segue.identifier == "add lot segue") {
            let destinationViewController = segue.destination as! AddLotViewController
            destinationViewController.lot_table = self
        }
    }
    
    // Add new lot to the list
    func addLot(name:String, view:MKCoordinateRegion, lotId: Int) {
        let new_lot = lot(name: name, view: view, lotId: lotId)
        lots.append(new_lot)
    }
    
    @IBAction func didSelectAddLot(_ sender: Any) {
        performSegue(withIdentifier: "add lot segue", sender: self)
    }
    
}
