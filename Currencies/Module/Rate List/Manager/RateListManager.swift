//
//  RateListManager.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import CoreData
import UIKit

protocol RateListManagerProtocol: class {
    func fetchRateList(baseCurrency: Currency?, completionHandler: @escaping ([Rate]?) -> Void)
    func isRateListContains(baseCurrency: Currency, convertCurrency: Currency, completionHandler: @escaping (Bool) -> Void)
    func updateOrCreateRate(from baseCurrency: Currency, and convertCurrency: Currency)
    func getLatest(rate: Rate, completionHandler: @escaping (Rate?, String?) -> Void)
    func getSymbols()
    func delete(convertCurrency: ConvertCurrency, in rate: Rate, completionHandler: @escaping (Rate?, Bool) -> Void)
}

class RateListManager: RateListManagerProtocol {
    
    // MARK: - Enums
    private enum Constant {
        static let accessKey = "e1c882f940b39aac3c509db3e0bbb9e8"
    }
    
    // MARK: - Methods
    func fetchRateList(baseCurrency: Currency? = nil, completionHandler: @escaping ([Rate]?) -> Void) {
        let fetchRequest: NSFetchRequest<Rate> = Rate.fetchRequest()
        
        if let currency = baseCurrency {
            fetchRequest.predicate = NSPredicate(format: "baseCurrency = %@",
                                                 argumentArray: [currency])
        }
        
        do {
            let rateList = try CoreDataManager.context.fetch(fetchRequest)
            completionHandler(rateList)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completionHandler(nil)
        }
    }
    
    func delete(convertCurrency: ConvertCurrency, in rate: Rate, completionHandler: @escaping (Rate?, Bool) -> Void) {
        guard let baseCurrency = rate.baseCurrency else {
            completionHandler(nil, false)
            return
        }

        let fetchRequest: NSFetchRequest<Rate> = Rate.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "baseCurrency = %@",
                                             argumentArray: [baseCurrency])
        
        do {
            let rateList = try CoreDataManager.context.fetch(fetchRequest)
            rateList[0].removeFromConvertCurrencyList(convertCurrency)
            
            var isRateDeleted = false
            
            if let convertCurrencyList = rateList[0].convertCurrencyList?.allObjects, convertCurrencyList.isEmpty {
                CoreDataManager.context.delete(rateList[0])
                isRateDeleted = true
            }
            
            CoreDataManager.saveContext()
            
            completionHandler(isRateDeleted ? nil : rateList[0], isRateDeleted)
        } catch _ {
            completionHandler(nil, false)
        }
    }
    
    func updateOrCreateRate(from baseCurrency: Currency, and convertCurrency: Currency) {
        let currency = ConvertCurrency(context: CoreDataManager.context)
        currency.name = convertCurrency.name
        currency.symbol = convertCurrency.symbol

        let fetchRequest: NSFetchRequest<Rate> = Rate.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "baseCurrency = %@",
                                             argumentArray: [baseCurrency])
        do {
            let rateList = try CoreDataManager.context.fetch(fetchRequest)
            if !rateList.isEmpty {
                rateList[0].addToConvertCurrencyList(currency)
            } else {
                let rate = Rate(context: CoreDataManager.context)
                rate.baseCurrency = baseCurrency
                rate.addToConvertCurrencyList(currency)
            }
            CoreDataManager.saveContext()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func updateRateValue(_ rate: Rate, from json: JSON?) -> Rate? {
        guard let baseCurrency = rate.baseCurrency else { return nil }
        let fetchRequest: NSFetchRequest<Rate> = Rate.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "baseCurrency = %@",
                                             argumentArray: [baseCurrency])
        
        do {
            let rateList = try CoreDataManager.context.fetch(fetchRequest)
            if !rateList.isEmpty {
                let rate = rateList[0]
                guard let convertCurrencyList = rate.convertCurrencyList?.allObjects as? [ConvertCurrency] else { return nil }
                convertCurrencyList.forEach { currency in
                    if let json = json {
                        if let rates = json["rates"] as? JSON, let symbol = currency.symbol,
                            let value = rates[symbol] as? Double {
                            currency.value = value
                        }
                    } else {
                        currency.value = -1
                    }

                }
                let currencyList = NSSet(array: convertCurrencyList)
                rate.convertCurrencyList = currencyList
                CoreDataManager.saveContext()
                return rate
            } else {
                return nil
            }
        } catch {
            return nil
        }
        
    }
    
    func getLatest(rate: Rate, completionHandler: @escaping (Rate?, String?) -> Void) {
        let base = rate.baseCurrency?.symbol ?? ""
        var symbolList: [String] = []
        if let convertCurrencyList = rate.convertCurrencyList?.allObjects as? [ConvertCurrency] {
            symbolList = convertCurrencyList.map { return $0.symbol }.compactMap { $0 }
        }
        let symbols = symbolList.joined(separator: ",")
        NetworkManager.shared.request(URL.latestRates(access_key: Constant.accessKey, base: base, symbols: symbols), method: .get) { [weak self] jsonResult in
            DispatchQueue.main.async { [weak self] in
                switch jsonResult {
                case .success(let json):
                    let updatedRate = self?.updateRateValue(rate, from: json)
                    completionHandler(updatedRate, nil)
                case .failed(let errorMessage):
                    let updatedRate = self?.updateRateValue(rate, from: nil)
                    completionHandler(updatedRate, errorMessage)
                }
            }
        }
    }
    
    func getSymbols() {
        NetworkManager.shared.request(URL.symbols(access_key: Constant.accessKey), method: .get) { jsonResult in
            switch jsonResult {
            case .success(let json):
                print(json)
            case .failed(let errorMessage):
                print(errorMessage)
            }
        }
    }
    
    func isRateListContains(baseCurrency: Currency, convertCurrency: Currency, completionHandler: @escaping (Bool) -> Void) {
        guard let currentConvertCurrencySymbol = convertCurrency.symbol else {
                completionHandler(false)
                return
        }
        
        fetchRateList(baseCurrency: baseCurrency) { rateList in
            guard let rateList = rateList else {
                completionHandler(false)
                return
            }
            
            var isRateListContains = false
            
            rateList.forEach { rate in
                if let convertCurrencyList = rate.convertCurrencyList?.allObjects as? [ConvertCurrency] {
                    let symbolList = convertCurrencyList.map {
                        return $0.symbol
                        }.compactMap { $0 }
                    isRateListContains = symbolList.contains(currentConvertCurrencySymbol)
                }
            }
            
            completionHandler(isRateListContains)
        }
    }
}
