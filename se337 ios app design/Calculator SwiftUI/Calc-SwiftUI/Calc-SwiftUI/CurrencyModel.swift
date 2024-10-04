//
//  CurrencyModel.swift
//  CurrencySwiftUI
//
//  Created by RamanLakshmanan on 11/19/22.
//

import Foundation

class CurrencyModel {
    private var conversionRate = 0.90
    
    func convertDollarToEuro (dollarAmount amount: Double) -> Double {
        return amount * conversionRate
    }

    func convertEurotoDollar (euroAmount amount: Double) -> Double {
        return amount / conversionRate
    }
}
