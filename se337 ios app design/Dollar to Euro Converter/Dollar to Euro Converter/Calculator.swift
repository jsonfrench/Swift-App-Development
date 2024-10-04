//
//  Calculator.swift
//  Dollar to Euro Converter
//
//  Created by Jason R. French on 9/11/24.
//

// Model Class

import Foundation

class Calculator {
    // provate variable for conversion factor
    private var conversionFactor = 0.98
    
    // setter and getter methods for conversion
    func setConversionFactor(rate: Double) {
        conversionFactor = rate
    }
    
    func getConversionFactor() -> Double {
        return conversionFactor
    }
    
    // Dollar to Euro conversion
    func dollarToEuro (dollar amount: Double) -> Double {
        return amount * conversionFactor
    }
    
    // Euro to Dollar conversion
    func euroToDollar (euro amount: Double) -> Double {
        return amount / conversionFactor
    }
}
