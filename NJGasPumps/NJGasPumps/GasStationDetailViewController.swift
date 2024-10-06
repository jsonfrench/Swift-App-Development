//
//  GasStationDetailViewController.swift
//  NJGasPumps
//
//  Created by Jason R. French on 10/5/24.
//

import UIKit

class GasStationDetailViewController: UIViewController {
    
    // declare some important variables
    var show_station_id: Int?
    var selected_station: GasPump?
    let gas_station_model:GasPumpsModel = GasPumpsModel.getInstance()
    
    // establish outlets to control the view
    @IBOutlet weak var station_icon: UIImageView!
    @IBOutlet weak var gas_price: UILabel!
    @IBOutlet weak var price_slider: UISlider!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderValueSet(_ sender: UISlider) {
        gas_price.text = String (format:"$%.2f", price_slider.value)
        gas_station_model.updatePrice(stationId: show_station_id!, updated_price: Double(price_slider.value))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // check what price is held in the gas statio array
//        print (gas_price.text!, Double(gas_station_model.getPumpInfo(stationId: show_station_id!)!.price))
        
        if let station_id = show_station_id {
            selected_station = gas_station_model.getPumpInfo(stationId: station_id)
            if (selected_station != nil) {
                self.title = selected_station?.name
                gas_price.text = String (format: "$%.2f", selected_station!.price)
                price_slider.value = Float(selected_station!.price)
                address1.text = selected_station?.address
                address2.text = selected_station?.address2
                
                if self.title!.contains("BP") {
                    station_icon.image = UIImage(named: "bp")
                } else if self.title!.contains("CHEVRON") {
                    station_icon.image = UIImage(named: "chevron")
                } else if self.title!.contains("GITGO") {
                    station_icon.image = UIImage(named: "citgo")
                } else if self.title!.contains("DELTA") {
                    station_icon.image = UIImage(named: "delta")
                } else if self.title!.contains("EXXONMOBIL") {
                    station_icon.image = UIImage(named: "exxonmobil")
                } else if self.title!.contains("EXXON") {
                    station_icon.image = UIImage(named: "exxon")
                } else if self.title!.contains("GETTY") {
                    station_icon.image = UIImage(named: "getty")
                } else if self.title!.contains("GULF") {
                    station_icon.image = UIImage(named: "gulf")
                } else if self.title!.contains("LUKOIL") {
                    station_icon.image = UIImage(named: "luke")
                } else if self.title!.contains("MARATHON") {
                    station_icon.image = UIImage(named: "marathon")
                } else if self.title!.contains("MOBIL") {
                    station_icon.image = UIImage(named: "mobil")
                } else if self.title!.contains("PHILLIPS") {
                    station_icon.image = UIImage(named: "phillips")
                } else if self.title!.contains("QUICKCHEK") {
                    station_icon.image = UIImage(named: "quickchek")
                } else if self.title!.contains("SHELL") {
                    station_icon.image = UIImage(named: "shell")
                } else if self.title!.contains("SPEEDWAY") {
                    station_icon.image = UIImage(named: "speedway")
                } else if self.title!.contains("SUNOCO") {
                    station_icon.image = UIImage(named: "sunoco")
                } else if self.title!.contains("TEXACO") {
                    station_icon.image = UIImage(named: "texaco")
                } else if self.title!.contains("WAWA") {
                    station_icon.image = UIImage(named: "wawa")
                } else if self.title!.contains("76") {
                    station_icon.image = UIImage(named: "76")
                } else {
                station_icon.image = UIImage(named: "generic")
                }
            }
        }
    }

    
}
