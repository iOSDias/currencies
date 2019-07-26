//
//  RateViewModel.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

struct RateViewModel {
    
    // MARK: - Properties
    private let baseCurrency: Currency
    private let convertCurrency: ConvertCurrency
    
    var baseCurrencyValue: String {
        let symbol = baseCurrency.symbol ?? ""
        return 1.description + " " + symbol
    }
    var baseCurrencyName: String {
        return baseCurrency.name ?? ""
    }
    var convertCurrencyValue: String {
        return convertCurrency.value == -1 ? "-" : convertCurrency.value.forTrailingZero
    }
    var convertCurrencyName: String {
        let name = convertCurrency.name ?? ""
        let symbol = convertCurrency.symbol ?? ""
        return symbol +  " • " + name
    }
    
    // MARK: - Inits
    init(baseCurrency: Currency, convertCurrency: ConvertCurrency) {
        self.baseCurrency = baseCurrency
        self.convertCurrency = convertCurrency
    }
}

