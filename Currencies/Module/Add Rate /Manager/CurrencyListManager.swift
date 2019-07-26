//
//  CurrencyListManager.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import CoreData
import UIKit

protocol CurrencyListManagerProtocol: class {
    func checkCurrencyEntity()
    func fetchCurrencyList(completionHandler: @escaping ([Currency]?) -> Void)
}

class CurrencyListManager: CurrencyListManagerProtocol {
    
    // MARK: - Enums
    private enum Constant {
        static let currencySymbolList: [String] = ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "ISK", "JPY", "KRW", "MAD", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "USD", "ZAR"]
        static let currencyNameList: [String] = ["Australian dollar", "Bulgarian lev", "Brazilian real", "Canadian dollar", "Swiss franc", "Renminbi (Chinese) yuan", "Czech koruna", "Danish krone", "Euro", "Pound sterling", "Hong Kong dollar", "Croatian kuna", "Hungarian forint", "Indonesian rupiah", "Israeli new shekel", "Indian rupee", "Icelandic króna", "Japanese yen", "South Korean won", "Moroccan dirham", "Mexican peso", "Malaysian ringgit", "Norwegian krone", "New Zealand dollar", "Philippine peso", "Polish złoty", "Romanian leu", "Russian ruble", "Swedish krona", "Singapore dollar", "Thai baht", "United States dollar", "South African rand"]
    }
    
    // MARK: - Methods
    func fetchCurrencyList(completionHandler: @escaping ([Currency]?) -> Void) {
        let fetchRequest: NSFetchRequest<Currency> = Currency.fetchRequest()

        do {
            let currencyList = try CoreDataManager.context.fetch(fetchRequest)
            completionHandler(currencyList)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completionHandler(nil)
        }
    }
    
    func checkCurrencyEntity() {
        fetchCurrencyList { currencyList in
            guard let currencyList = currencyList else { return }
            if currencyList.isEmpty {
                Constant.currencySymbolList.enumerated().forEach { index, symbol in
                    let currency = Currency(context: CoreDataManager.context)
                    currency.symbol = symbol
                    currency.name = Constant.currencyNameList[index]
                    CoreDataManager.saveContext()
                }
            }
        }
    }
}
