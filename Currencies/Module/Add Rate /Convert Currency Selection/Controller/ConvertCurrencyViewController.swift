//
//  ConvertCurrencyViewController.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

class ConvertCurrencyViewController: IndicatorViewableViewController, ViewControllerProtocol {
    
    // MARK: - Views
    lazy var mainView: CurrencySelectionView = {
        let view = CurrencySelectionView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    var router: RouterProtocol!
    lazy var currencyListManager: CurrencyListManagerProtocol = CurrencyListManager()
    lazy var rateListManager: RateListManagerProtocol = RateListManager()

    var baseCurrency: Currency!
    var currencyList: [Currency] = [] {
        didSet {
            if let index = currencyList.firstIndex(of: baseCurrency) {
                currencyList.remove(at: index)
            }
        }
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        configureView()
        configureMainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        fetchCurrencyList()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
     
        updateMainViewConstraints()
    }
}

extension ConvertCurrencyViewController {
    
    // MARK: - Configure view
    private func configureView() {
        view.backgroundColor = ColorName.grayLight.color
    }
}

extension ConvertCurrencyViewController {
    
    // MARK: - Configure mainView
    private func configureMainView() {
        view.addSubview(mainView)
        makeMainViewConstraints()
    }
    
    private func makeMainViewConstraints() {
        mainView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func updateMainViewConstraints() {
        if #available(iOS 11.0, *) {
            
        } else {
            mainView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(topLayoutGuide.length)
            }
        }
    }
}
