//
//  Order.swift
//  CupcakeCorner
//
//  Created by Németh Gergely on 2019. 11. 12..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false

    // Address
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        var cost = Double(quantity) * 2 // cake price is 2
        cost += (Double(type) / 2) // cost more complicated case
        if extraFrosting { // extra frosting is 1
            cost += Double(quantity)
        }
        if addSprinkles { // extra frosting is 0.5
            cost += Double(quantity) / 2
        }

        return cost
    }
}
