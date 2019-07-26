//
//  RateList+Network.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension RateListViewController {
    
    // MARK: - Network methods
    func fetchRateList() {
        startAnimating()
        
        rateListManager.fetchRateList(baseCurrency: nil) { [weak self] rateList in
            guard let `self` = self, let rateList = rateList else { return }
            
            self.rateList = rateList
            self.mainView.reloadData()

            if rateList.isEmpty {
                self.stopAnimating()
            } else {
                self.getLatestRates()
            }
        }
    }
    
    func getLatestRates() {
        self.rateList.forEach { rate in
            getLatest(rate: rate, completionHandler: { updatedRate in
                if let index = self.rateList.firstIndex(where: { $0.baseCurrency?.symbol == updatedRate.baseCurrency?.symbol }) {
                    self.rateList[index] = updatedRate
                }
                if rate == self.rateList.last {
                    self.stopAnimating()
                    self.mainView.reloadData()
                }
            })
        }
    }
    
    func getLatest(rate: Rate, completionHandler: @escaping (Rate) -> Void) {

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let `self` = self else { return }
            
            self.rateListManager.getLatest(rate: rate, completionHandler: { [weak self] updatedRate, errorMesage in
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    
                    if let message = errorMesage {
                        self.showAlert(with: message, backgroundColor: ColorName.red.color)
                    }
                    
                    if let updatedRate = updatedRate {
                        completionHandler(updatedRate)
                    } 
                }
            })
        }
    }
    
}
