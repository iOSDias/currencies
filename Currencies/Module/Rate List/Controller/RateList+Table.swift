//
//  RateList+Table.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension RateListViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return rateList.count
    }
    func getConvertCurrencyList(from rate: Rate) -> [ConvertCurrency] {
        guard let convertCurrencyList = rate.convertCurrencyList?.allObjects as? [ConvertCurrency] else {
            return []
        }
        return convertCurrencyList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getConvertCurrencyList(from: rateList[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RateListCell = tableView.dequeueReusableCell(for: indexPath)
        let rate = rateList[indexPath.section]
        if let baseCurrency = rate.baseCurrency {
            let convertCurrency = getConvertCurrencyList(from: rate)[indexPath.row]
            cell.viewModel = RateViewModel(baseCurrency: baseCurrency, convertCurrency: convertCurrency)
        }
        return cell
    }
}

extension RateListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let rate = rateList[indexPath.section]
            let currency = getConvertCurrencyList(from: rate)[indexPath.row]
            self.rateListManager.delete(convertCurrency: currency, in: rate) { [weak self] updatedRate, isRateDeleted in
                guard let `self` = self else { return }

                if isRateDeleted {
                    self.rateList.remove(at: indexPath.section)
                } else if let updatedRate = updatedRate {
                    self.rateList[indexPath.section] = updatedRate
                }
                
                self.mainView.reloadData()
            }
        }
    }
}
