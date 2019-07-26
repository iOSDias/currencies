//
//  RateListViewController.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

class RateListViewController: IndicatorViewableViewController, ViewControllerProtocol {
    
    // MARK: - Views
    lazy var mainView: RateListView = {
        let view = RateListView()
        view.delegate = self 
        return view
    }()
    
    // MARK: - Properties
    var router: RouterProtocol!
    var rateList: [Rate] = []
    lazy var rateListManager: RateListManagerProtocol = RateListManager()
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        configureView()
        configureMainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRateList()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateMainViewConstraints()
    }
}

extension RateListViewController {
    
    // MARK: - Configure view
    private func configureView() {
        view.backgroundColor = ColorName.grayLight.color
    }
}

extension RateListViewController {
    
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
