//
//  BaseCurrency+Table.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension BaseCurrencyViewController: UITableViewDataSource {
    
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

extension BaseCurrencyViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let context = BaseCurrencyRouter.RouteType.convertCurrencySelection(baseCurrency: currencyList[indexPath.row])
        router.enqueueRoute(with: context)
    }
}
