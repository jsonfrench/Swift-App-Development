//
//  ContentView.swift
//  Calc-SwiftUI
//
//  Created by RamanLakshmanan on 11/21/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currencyVM = CurrencyVM()
    @FocusState private var dollarsIsFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center , spacing: 30) {
                HStack {
                    Text("Dollars")
                        .padding()
                    Spacer()
                    
                    TextField(currencyVM.dollarAmount, text: $currencyVM.dollarAmount)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        
                        .keyboardType(.decimalPad)
                        .focused($dollarsIsFocused)
                    Spacer()
                }
                HStack {
                    Text("Euros")
                        .padding()
                    Spacer()
                    TextField(currencyVM.euroAmount, text: $currencyVM.euroAmount)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        
                        .keyboardType(.decimalPad)
                    Spacer()
                }
                
                Spacer()

                HStack {
                    Spacer()
                    Button ("Convert to Euro", action: {
                            currencyVM.convertCurrency()
                            dollarsIsFocused = false
                        })
                        .tint(.red)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .controlSize(.large)
                    Spacer()
                    
                    Button ("Convert to Dollar", action: {
                        currencyVM.convertToDollar()
                        dollarsIsFocused = false
                        })
                        .tint(.red)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .controlSize(.large)
                    Spacer()
                }
                
                Spacer()
                Spacer()
                Spacer()

            }
            .navigationTitle("Euro Currency Calcuator")
            .navigationBarTitleDisplayMode(.inline)
        }
        }
       
}

#Preview {
    ContentView()
}
