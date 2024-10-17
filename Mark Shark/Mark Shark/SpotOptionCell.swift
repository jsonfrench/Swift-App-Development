//
//  SpotOptionCell.swift
//  Mark Shark
//
//  Created by Jason R. French on 10/17/24.
//

import UIKit

class SpotOptionCell: UITableViewCell {

    @IBOutlet weak var option_title: UILabel!
    @IBOutlet weak var toggle_switch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
