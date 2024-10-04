//
//  CalculatorViewController.swift
//  Dollar to Euro Converter
//
//  Created by Jason R. French on 9/11/24.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var euroAmount: UITextField!
    @IBOutlet weak var dollarAmount: UITextField!
    @IBOutlet weak var conversionFactor: UITextField!
    
    let myCalculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        euroAmount.text = "0.00"
        dollarAmount.text = "0.00"
        conversionFactor.text = String (format: "%.2f", myCalculator.getConversionFactor())
    }
    
    
    @IBAction func convertToEuro(_ sender: UIButton) {
        var euros = 0.0
        if let dollar = Double (dollarAmount.text!) {
            euros = myCalculator.dollarToEuro(dollar: dollar)
        }
        euroAmount.text = String (format: "%.2f", euros)
    }

    @IBAction func convertToDollar(_ sender: UIButton) {
        var dollars = 0.0
        if let euro = Double (euroAmount.text!) {
            dollars = myCalculator.euroToDollar(euro: euro)
        }
        dollarAmount.text = String (format: "%.2f", dollars)
    }
    
    @IBAction func updateConversionFactor(_ sender: UIButton) {
        if let new_rate = Double(conversionFactor.text!) {
            myCalculator.setConversionFactor(rate: new_rate)
        }
        conversionFactor.text = String (format: "%.2f", myCalculator.getConversionFactor())
    }
    
}
