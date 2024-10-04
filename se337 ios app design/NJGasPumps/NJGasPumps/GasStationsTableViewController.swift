//
//  GasStationsTableViewController.swift
//  NJGasPumps
//
//  Created by Jason R. French on 10/1/24.
//

// reference:
// https://stackoverflow.com/questions/33234180/uitableview-example-for-swift

import UIKit

class GasStationsTableViewController: UITableViewController {
    
    // determines the number of sections in the table
    var number_of_sections: Int = 1
    
    // get the single instance of gasPumpsModel
    let gas_station_model:GasPumpsModel = GasPumpsModel.getInstance()

    // test data model
//    let gas_stations: [String] = ["Exxon","Mobil","Lukoil","Shell"]
    var gas_stations: [String] = []
//    gas_stations = gas_station_model.getStations()
    
    // set cell reuse identifier so that cells can be reused
    let cell_reuse_identifier = "gas_station_cell"
    
    @IBOutlet var gas_station_table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set data source to be array of gas station names
        gas_stations = gas_station_model.getStations()
        
        // register table view cell class and the reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell_reuse_identifier)
        
        // let the gas station view know where to get its data from
        gas_station_table.delegate = self
        gas_station_table.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        // the number of sections seems to be how many times the rows get repeated
        return number_of_sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return self.gas_stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_identifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.gas_stations[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
