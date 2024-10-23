//
//  ViewController.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/17/24.
//

import UIKit
import MapKit

class SpotAttributesTableViewController: UITableViewController {
    
    var coordinate: CLLocationCoordinate2D?
    var annotation_title: String?
    var annotation_subtitle: String?
    
    let number_of_sections = 1
    let cell_height: CGFloat = 75
    
    let cell_reuse_identifier = "spot attribute"
    
    let options: [String] = ["Handicapped", "Reserved", "Faculty Spot"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("table view loaded!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // call method to add spot using attributed passed in by addSpotViewController
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return number_of_sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_identifier, for: indexPath) as! SpotOptionCell

        cell.option_title.text = self.options[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_height
    }
    
}
