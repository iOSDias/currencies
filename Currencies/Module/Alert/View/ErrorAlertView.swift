//
//  ErrorAlertView.swift
//  UMAG
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias. All rights reserved.
//

import SwiftEntryKit

class AlertView: UIView {
    
    // MARK: - Constants
    private enum Constant {
        enum TitleLabel {
            static let width = UIScreen.main.bounds.width - Constant.TitleLabel.Offset.left * 2
            
            enum Offset {
                static let left = Constant.CloseButton.Offset.right + Constant.CloseButton.Size.side + Constant.TitleLabel.Offset.right
                static let right: CGFloat = 24
                static let bottom: CGFloat = 13
                static let top: CGFloat = 13
            }
        }
        
        enum CloseButton {
            enum Offset {
                static let top: CGFloat = 13
                static let right: CGFloat = UIScreen.main.bounds.width * 0.05
                static let bottom: CGFloat = 13
            }
            enum Size {
                static var side: CGFloat = 32
            }
        }
    }
    
    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeButtonTouchUp), for: .touchUpInside)
        button.setImage(Asset.alertCloseIcon.image, for: .normal)
        button.contentVerticalAlignment = .top
        return button
    }()
    
    // MARK: - Methods
    @objc private func closeButtonTouchUp() {
        SwiftEntryKit.dismiss()
    }
    
    private func configureViews() {
        if !titleLabel.isMoreThanOneLine(width: Constant.TitleLabel.width) {
            closeButton.contentVerticalAlignment = .center
        }
        
        [titleLabel, closeButton].forEach { addSubview($0) }

    }
    
    private func makeConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.CloseButton.Offset.top)
            make.trailing.equalToSuperview().offset(-Constant.CloseButton.Offset.right)
            make.width.height.equalTo(Constant.CloseButton.Size.side)
            
            if !titleLabel.isMoreThanOneLine(width: Constant.TitleLabel.width) {
                make.bottom.equalToSuperview().offset(-Constant.CloseButton.Offset.bottom)
            }
        }
        
        let textHeight = titleLabel.text!.height(withConstrainedWidth: Constant.TitleLabel.width, font: titleLabel.font)
        titleLabel.snp.makeConstraints { make in
            if titleLabel.isMoreThanOneLine(width: Constant.TitleLabel.width) {
                make.top.equalToSuperview().offset(Constant.TitleLabel.Offset.top)
                make.bottom.equalToSuperview().offset(-Constant.TitleLabel.Offset.bottom)
            } else {
                make.centerY.equalTo(closeButton)
            }
            make.height.equalTo(textHeight)
            make.trailing.equalTo(closeButton.snp.leading).offset(-Constant.TitleLabel.Offset.right)
            make.leading.equalToSuperview().offset(Constant.TitleLabel.Offset.left)
        }
    }
    
    // MARK: - Inits
    init(message: String) {
        super.init(frame: .zero)
        
        titleLabel.text = message
        
        configureViews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
