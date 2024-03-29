//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Németh Gergely on 2019. 11. 11..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var observableOrder = ObservableOrder()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $observableOrder.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $observableOrder.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(observableOrder.order.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $observableOrder.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }

                    if observableOrder.order.specialRequestEnabled {
                        Toggle(isOn: $observableOrder.order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $observableOrder.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(observableOrder: observableOrder)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
