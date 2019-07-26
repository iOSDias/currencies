//
//  CurrencySelectionViewModel.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

struct CurrencySelectionViewModel {
    
    // MARK: - Properties
    private let currency: Currency
    
    var symbol: String {
        return currency.symbol ?? ""
    }
    var name: String {
        return currency.name ?? ""
    }
    
    // MARK: - Inits 
    init(currency: Currency) {
        self.currency = currency
    }
}

