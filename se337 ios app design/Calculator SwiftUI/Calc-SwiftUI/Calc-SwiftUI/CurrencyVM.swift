//
//  CurrencyVM.swift
//  CurrencyAppMVVM
//
//  Created by RamanLakshmanan on 11/22/22.
//

import Foundation

@Observable class CurrencyVM {
    var dollarAmount: String
    var euroAmount: String
    
    let currencyModel = CurrencyModel()
    
    init () {
        dollarAmount = "0.00"
        euroAmount = "0.00"
    }
    
    func convertCurrency () {
        if let amount = Double(dollarAmount) {
            let result = currencyModel.convertDollarToEuro(dollarAmount: amount)
            euroAmount = String (format: "%.2f", result)
        }
    }
    
    func convertToDollar () {
        if let amount = Double(euroAmount) {
            let result = currencyModel.convertEurotoDollar(euroAmount: amount)
            dollarAmount = String (format: "%.2f", result)
        }
    }
    
}
