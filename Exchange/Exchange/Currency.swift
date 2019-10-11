//
//  Currency.swift
//  Exchange
//
//  Created by Németh Gergely on 2019. 10. 11..
//  Copyright © 2019. Németh Gergely. All rights reserved.
//

import Foundation

enum Currency: String, CaseIterable {
    case HUF
    case EUR
    case USD
    
    var currencySign: String {
        switch self {
        case .HUF: return "HUF"
        case .EUR: return "€"
        case .USD: return "$"
        }
    }
}

extension Currency {
    private static let rates: [Currency: Double] = [
        .HUF: 1,
        .EUR: 335,
        .USD: 300
    ]
    
    static func getRate(from fromCurrency: Currency, to toCurrency: Currency) -> Double {
        rates[fromCurrency, default: 1]/rates[toCurrency, default: 1] // Exchanges are HUF based
    }
}
