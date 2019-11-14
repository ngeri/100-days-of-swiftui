//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Németh Gergely on 2019. 11. 12..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var observableOrder = ObservableOrder()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $observableOrder.order.name)
                TextField("Street Address", text: $observableOrder.order.streetAddress)
                TextField("City", text: $observableOrder.order.city)
                TextField("Zip", text: $observableOrder.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(observableOrder: observableOrder)) {
                    Text("Check out")
                }
            }
            .disabled(observableOrder.order.hasValidAddress == false)

            
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(observableOrder: ObservableOrder())
    }
}
