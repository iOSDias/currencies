//
//  ConvertCurrency+Navigation.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension ConvertCurrencyViewController {
    
    // MARK: - Constants
    private enum Constant {
        enum Attribute {
            static let title: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                .foregroundColor: ColorName.black.color
            ]
        }
    }
    
    // MARK: - Configure navigationBar
    func configureNavigationBar() {
        guard let navigationController = navigationController else { return }
        
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.navigationBar.setTransparent(true)
        navigationController.navigationBar.backgroundColor = ColorName.grayLight.color
        
        let navigationBar = navigationController.navigationBar
        navigationBar.titleTextAttributes = Constant.Attribute.title
        
        navigationItem.title = "Second currency"        
    }
}
