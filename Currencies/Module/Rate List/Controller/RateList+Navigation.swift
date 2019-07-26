//
//  RateList+Navigation.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension RateListViewController {
    
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
    @objc private func addButtonTouchUpInside() {
        let context = RateListRouter.RouteType.addRate
        router.enqueueRoute(with: context)
    }
    
    private func configureBarButtonItems() {
        let addBarButtonItem: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(image: Asset.rateListAddIcon.image, style: .plain, target: self, action:  #selector(addButtonTouchUpInside))
            return barButtonItem
        }()
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    func configureNavigationBar() {
        guard let navigationController = navigationController else { return }
        
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.navigationBar.setTransparent(true)
        navigationController.navigationBar.backgroundColor = ColorName.grayLight.color

        let navigationBar = navigationController.navigationBar
        navigationBar.titleTextAttributes = Constant.Attribute.title
        
        navigationItem.title = "Rates"
        
        configureBarButtonItems()
    }
}

