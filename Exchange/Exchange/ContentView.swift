//
//  ContentView.swift
//  Exchange
//
//  Created by Németh Gergely on 2019. 10. 11..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var firstSelectedCurrency = 0
    @State private var secondSelectedCurrency = 1
    @State private var amountString = ""
    private let currencies = Currency.allCases
    
    private var amount: Double {
        let rate = Currency.getRate(from: currencies[firstSelectedCurrency], to: currencies[secondSelectedCurrency])
        return (Double(amountString) ?? 0) * rate
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("From Currency")) {
                    Picker("From currency", selection: $firstSelectedCurrency) {
                        ForEach(0..<currencies.count) {
                            Text(self.currencies[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("To Currency")) {
                    Picker("To currency", selection: $secondSelectedCurrency) {
                        ForEach(0..<currencies.count) {
                            Text(self.currencies[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    TextField("Amount to be exchange", text: $amountString)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Amount")) {
                    Text("\(self.amount, specifier: "%.2f") \(self.currencies[secondSelectedCurrency].currencySign)")
                }
            }
            .navigationBarTitle("Currency Exchange")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
