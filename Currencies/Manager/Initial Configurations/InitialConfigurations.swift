//
//  InitialConfigurations.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import NVActivityIndicatorView
import SnapKit
import UIKit

protocol InitialConfigurationsProtocol: class {
    func load(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

class InitialConfigurations: InitialConfigurationsProtocol {
    
    // MARK: - Constants
    private enum Constant {
        enum Attribute {
            static let barButtonItem: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
        }
    }
    
    // MARK: - Propreties
    private lazy var currencyListManager: CurrencyListManagerProtocol = CurrencyListManager()
    
    // MARK: - Methods
    private func configureBarButtonItem() {
        UIBarButtonItem.appearance().setTitleTextAttributes(Constant.Attribute.barButtonItem, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(Constant.Attribute.barButtonItem, for: .highlighted)
    }
    
    private func configureIndicatorView() {
        NVActivityIndicatorView.DEFAULT_TYPE = .circleStrokeSpin
        NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 150
    }
    
    private func configureCurrencyList() {
        currencyListManager.checkCurrencyEntity()
    }

    func load(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        configureBarButtonItem()
        configureIndicatorView()
        configureCurrencyList()
    }
}
