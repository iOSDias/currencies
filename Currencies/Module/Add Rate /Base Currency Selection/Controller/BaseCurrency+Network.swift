//
//  BaseCurrency+Network.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension BaseCurrencyViewController {
    
    // MARK: - Network methods
    func fetchCurrencyList() {
        currencyListManager.fetchCurrencyList { [weak self] currencyList in
            guard let `self` = self, let currencyList = currencyList else { return }
            
            self.currencyList = currencyList
            self.mainView.reloadData()
        }
    }
}
