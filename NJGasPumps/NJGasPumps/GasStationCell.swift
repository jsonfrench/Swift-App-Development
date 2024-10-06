//
//  GasStationTableViewCell.swift
//  NJGasPumps
//
//  Created by Jason R. French on 10/1/24.
//

import UIKit

class GasStationCell: UITableViewCell {
    
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationCity: UILabel!
    @IBOutlet weak var stationIcon: UIImageView!
    @IBOutlet weak var stationPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
