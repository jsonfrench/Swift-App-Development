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
    
    let lot_model = lotModel.sharedInstance
    var selected_lot_id: UUID?
    var lots: [Lot] = []
    
    let notificationLot = Notification.Name(rawValue: lotNotificationKey)

    // Manage view loading, dissapearing, appearing... //

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        lots = lot_model.getLots()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createObservers()
        lot_model.observeLots()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lot_model.observeLots()
        NotificationCenter.default.removeObserver(self)
    }

    // Set Observers
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(notification:)), name: notificationLot, object: nil)
    }
    
    @objc
    func refreshTable(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    
    // Handle Table Actions and Rendering //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return number_of_sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return lots.count
        return lot_model.lots.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_identifier, for: indexPath) as! SelectLotViewCell
//        cell.option_title.text = self.lots[indexPath.row].name
        cell.option_title.text = self.lot_model.lots[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selected_lot_id = lots[indexPath.row].lotId
        selected_lot_id = lot_model.lots[indexPath.row].lotId
        performSegue(withIdentifier: "add spot segue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "add spot segue") {
            let destinationViewController = segue.destination as! AddSpotViewController
            destinationViewController.selected_lot_id = selected_lot_id
        }
        if (segue.identifier == "view lot segue") {
            let destinationViewController = segue.destination as! LotViewController
            destinationViewController.selected_lot_id = selected_lot_id
        }
        if (segue.identifier == "add lot segue") {
            let destinationViewController = segue.destination as! AddLotViewController
            destinationViewController.lot_table = self
        }
    }
    
    @IBAction func didSelectAddLot(_ sender: Any) {
        performSegue(withIdentifier: "add lot segue", sender: self)
    }
    
    // Add Swiping
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // View lot
        let viewLot = UIContextualAction(style: .normal, title: "View") { (action, view, completionHandler) in
            self.handleView(at: indexPath)
            completionHandler(true)
        }
        viewLot.backgroundColor = .blue
        // Delete Lot
        let deleteLot = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.handleDelete(at: indexPath)
            completionHandler(true) // Call completion handler
        }
        deleteLot.backgroundColor = .red

        let configuration = UISwipeActionsConfiguration(actions: [viewLot])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    func handleView(at indexPath: IndexPath) {
//        selected_lot_id = lots[indexPath.row].lotId
        selected_lot_id = lot_model.lots[indexPath.row].lotId
        performSegue(withIdentifier: "view lot segue", sender: self)
    }

    func handleDelete(at indexPath: IndexPath) {
//        selected_lot_id = lots[indexPath.row].lotId
    }

    
    
    
}
