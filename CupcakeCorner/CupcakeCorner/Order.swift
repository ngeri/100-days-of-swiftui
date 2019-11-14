//
//  Order.swift
//  CupcakeCorner
//
//  Created by Németh Gergely on 2019. 11. 12..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.isEmptyOrWhitespace || streetAddress.isEmptyOrWhitespace || city.isEmptyOrWhitespace || zip.isEmptyOrWhitespace {
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

final class ObservableOrder: ObservableObject {
    @Published var order = Order()
}

private extension String {
    var isEmptyOrWhitespace: Bool {
        if isEmpty {
            return true
        }
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
