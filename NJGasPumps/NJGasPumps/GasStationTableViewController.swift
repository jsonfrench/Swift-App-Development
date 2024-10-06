//
//  GasStationsTableViewController.swift
//  NJGasPumps
//
//  Created by Jason R. French on 10/1/24.
//

import UIKit

class GasStationTableViewController: UITableViewController {
    
    // determines the number of sections in the table
    var number_of_sections: Int = 1
    
    // get the single instance of gasPumpsModel
    let gas_station_model:GasPumpsModel = GasPumpsModel.getInstance()

    // store gas station info in list
    var gas_stations: [GasPump] = []
    
    var selectedStationId: Int?

    // set cell reuse identifier so that cells can be reused
    let cell_reuse_identifier = "gas_station_cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gas_stations = gas_station_model.getPumps()
        
        // update price values when we go back to the screen
        tableView.reloadData()
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
  
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_identifier, for: indexPath) as! GasStationCell

        cell.stationName.text = self.gas_stations[indexPath.row].name
        cell.stationCity.text = self.gas_stations[indexPath.row].city
        cell.stationPrice.text = String (format:"$%.2f", self.gas_stations[indexPath.row].price)
        
        // set image depending on brand name - could be moved to a function
        if self.gas_stations[indexPath.row].name.contains("BP") {
            cell.stationIcon.image = UIImage(named: "bp")
        } else if self.gas_stations[indexPath.row].name.contains("CHEVRON") {
            cell.stationIcon.image = UIImage(named: "chevron")
        } else if self.gas_stations[indexPath.row].name.contains("CITGO") {
            cell.stationIcon.image = UIImage(named: "citgo")
        }  else if self.gas_stations[indexPath.row].name.contains("DELTA") {
            cell.stationIcon.image = UIImage(named: "delta")
        } else if self.gas_stations[indexPath.row].name.contains("EXXONMOBIL") {
            cell.stationIcon.image = UIImage(named: "exxonmobil")
        } else if self.gas_stations[indexPath.row].name.contains("EXXON") {
            cell.stationIcon.image = UIImage(named: "exxon")
        } else if self.gas_stations[indexPath.row].name.contains("GETTY") {
            cell.stationIcon.image = UIImage(named: "getty")
        } else if self.gas_stations[indexPath.row].name.contains("GULF") {
            cell.stationIcon.image = UIImage(named: "gulf")
        } else if self.gas_stations[indexPath.row].name.contains("LUKOIL") {
            cell.stationIcon.image = UIImage(named: "luke")
        } else if self.gas_stations[indexPath.row].name.contains("MARATHON") {
            cell.stationIcon.image = UIImage(named: "marathon")
        } else if self.gas_stations[indexPath.row].name.contains("MOBIL") {
            cell.stationIcon.image = UIImage(named: "mobil")
        } else if self.gas_stations[indexPath.row].name.contains("PHILLIPS") {
            cell.stationIcon.image = UIImage(named: "phillips")
        } else if self.gas_stations[indexPath.row].name.contains("QUICKCHEK") {
            cell.stationIcon.image = UIImage(named: "quickchek")
        } else if self.gas_stations[indexPath.row].name.contains("SHELL") {
            cell.stationIcon.image = UIImage(named: "shell")
        } else if self.gas_stations[indexPath.row].name.contains("SPEEDWAY") {
            cell.stationIcon.image = UIImage(named: "speedway")
        } else if self.gas_stations[indexPath.row].name.contains("SUNOCO") {
            cell.stationIcon.image = UIImage(named: "sunoco")
        } else if self.gas_stations[indexPath.row].name.contains("TEXACO") {
            cell.stationIcon.image = UIImage(named: "texaco")
        } else if self.gas_stations[indexPath.row].name.contains("WAWA") {
            cell.stationIcon.image = UIImage(named: "wawa")
        } else if self.gas_stations[indexPath.row].name.contains("76") {
            cell.stationIcon.image = UIImage(named: "76")
        } else {
            cell.stationIcon.image = UIImage(named: "generic")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStationId = gas_stations[indexPath.row].objectId
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let destinationViewController = segue.destination as! GasStationDetailViewController
            destinationViewController.show_station_id = selectedStationId
        }
    }

}
