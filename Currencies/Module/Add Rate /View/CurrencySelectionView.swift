//
//  BaseCurrencySelectionView.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

protocol CurrencySelectionViewDelegate: UITableViewDataSource, UITableViewDelegate {}

class CurrencySelectionView: UIView {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 55
        tableView.estimatedRowHeight = 55
        tableView.backgroundColor = .clear
        tableView.register(cellClass: CurrencySelectionCell.self)
        return tableView
    }()
    
    // MARK: - Properties
    weak var delegate: CurrencySelectionViewDelegate? {
        didSet {
            tableView.delegate = delegate
            tableView.dataSource = delegate
        }
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencySelectionView {
    
    // MARK: - Methods
    func reloadData() {
        tableView.reloadData()
    }
}

extension CurrencySelectionView {
    
    // MARK: - Layout methods
    private func configureViews() {
        backgroundColor = ColorName.white.color
        addSubview(tableView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

