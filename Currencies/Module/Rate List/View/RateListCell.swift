//
//  RateListCell.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import QuickLayout
import UIKit

class RateListCell: UITableViewCell {

    // MARK: - Views
    private lazy var baseCurrencyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = ColorName.black.color
        label.horizontalHuggingPriority = .must
        return label
    }()
    private lazy var baseCurrencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ColorName.grayMiddle.color
        label.horizontalHuggingPriority = .must
        return label
    }()
    private lazy var convertCurrencyValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = ColorName.black.color
        label.textAlignment = .right
        return label
    }()
    private lazy var convertCurrencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ColorName.grayMiddle.color
        label.textAlignment = .right
        return label
    }()
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.line.color
        return view
    }()
    
    // MARK: - Properties
    var viewModel: RateViewModel! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Inis
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RateListCell {
    
    // MARK: - Methods
    private func updateUI() {
        baseCurrencyValueLabel.text = viewModel.baseCurrencyValue
        baseCurrencyNameLabel.text = viewModel.baseCurrencyName
        convertCurrencyValueLabel.text = viewModel.convertCurrencyValue
        convertCurrencyNameLabel.text = viewModel.convertCurrencyName
    }
}

extension RateListCell {
    
    // MARK: - Layout methods
    private func configureViews() {
        selectionStyle = .none
        [baseCurrencyValueLabel, baseCurrencyNameLabel, convertCurrencyValueLabel, convertCurrencyNameLabel, lineView].forEach { addSubview($0) }
        makeConstraints()
    }
    
    private func makeConstraints() {
        baseCurrencyValueLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
        baseCurrencyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(baseCurrencyValueLabel.snp.bottom).offset(8)
            make.leading.equalTo(baseCurrencyValueLabel)
        }
        convertCurrencyValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(baseCurrencyValueLabel)
            make.leading.equalTo(baseCurrencyValueLabel.snp.trailing).offset(8)
        }
        convertCurrencyNameLabel.snp.makeConstraints { make in
            make.trailing.equalTo(convertCurrencyValueLabel)
            make.leading.equalTo(baseCurrencyNameLabel.snp.trailing).offset(8)
            make.centerY.equalTo(baseCurrencyNameLabel)
        }
        lineView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(baseCurrencyValueLabel)
            make.height.equalTo(1)
        }
    }
}
