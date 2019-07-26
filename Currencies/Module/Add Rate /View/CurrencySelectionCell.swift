//
//  CurrencySelectionCell.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

class CurrencySelectionCell: UITableViewCell {
    
    // MARK: - Views
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = ColorName.black.color
        label.horizontalHuggingPriority = .must
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = ColorName.black.color.withAlphaComponent(0.4)
        return label
    }()
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorName.line.color
        return view
    }()
    
    // MARK: - Properties
    var viewModel: CurrencySelectionViewModel! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Life cycle
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        backgroundColor = highlighted ? ColorName.grayLight.color : .clear
    }
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencySelectionCell {
    
    // MARK: - Methods
    private func updateUI() {
        symbolLabel.text = viewModel.symbol
        nameLabel.text = viewModel.name
    }
}

extension CurrencySelectionCell {
    
    // MARK: - Layout methods
    private func configureViews() {
        selectionStyle = .none
        [symbolLabel, nameLabel, lineView].forEach { addSubview($0) }
        makeConstraints()
    }
    
    private func makeConstraints() {
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(symbolLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.leading.equalTo(symbolLabel)
            make.height.equalTo(1)
        }
    }
}
