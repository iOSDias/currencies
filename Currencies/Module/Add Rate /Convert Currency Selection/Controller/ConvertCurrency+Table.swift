//
//  ConvertCurrency+Table.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension ConvertCurrencyViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrencySelectionCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = CurrencySelectionViewModel(currency: currencyList[indexPath.row])
        return cell
    }
}

extension ConvertCurrencyViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let convertCurrency = currencyList[indexPath.row]
        
        rateListManager.isRateListContains(baseCurrency: baseCurrency, convertCurrency: convertCurrency) { [weak self] contains in
            guard let `self` = self else { return }
            
            if contains {
                self.showAlert(with: "Rate already exists", backgroundColor: ColorName.red.color)
            } else {
                self.rateListManager.updateOrCreateRate(from: self.baseCurrency, and: convertCurrency)
                self.router.dismiss()
            }
        }
    }
}

