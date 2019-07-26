//
//  RateListView.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

protocol RateListViewDelegate: UITableViewDataSource, UITableViewDelegate {
    func view(_ view: RateListView, refreshControlValueChanged refreshControl: UIRefreshControl)
}

class RateListView: UIView {
    
    // MARK: - Views
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        return refreshControl
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 86
        tableView.estimatedRowHeight = 86
        tableView.backgroundColor = .clear
        tableView.refreshControl = refreshControl
        tableView.register(cellClass: RateListCell.self)
        return tableView
    }()
    
    // MARK: - Properties
    weak var delegate: RateListViewDelegate? {
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

extension RateListView {
    
    // MARK: - Methods
    @objc private func refreshControlValueChanged() {
        delegate?.view(self, refreshControlValueChanged: refreshControl)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension RateListView {
    
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
