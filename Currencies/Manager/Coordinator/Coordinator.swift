//
//  Coordinator.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {
    func presentInitialModule()
}

class Coordinator: CoordinatorProtocol {

    // MARK: - Properties
    static let shared: CoordinatorProtocol = Coordinator()

    // MARK: - Methods
    func presentRateListModule() {
        let router = RateListRouter()
        let viewController = RateListViewController()
        configureViewController(viewController, router: router)
        presentNavigationController(with: viewController)
    }
    
    func presentInitialModule() {
        presentRateListModule()
    }
}

extension Coordinator {
    
    // MARK: - Private module and configuration methods
    private func configureViewController(_ viewController: (IndicatorViewableViewController & ViewControllerProtocol), router: RouterProtocol) {
        viewController.router = router
        router.baseViewController = viewController
    }
    
    private func presentNavigationController(with rootViewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = ColorName.blue.color
        navigationController.navigationBar.backgroundColor = ColorName.grayLight.color
        UIApplication.shared.window.rootViewController = navigationController
        UIApplication.shared.window.makeKeyAndVisible()
    }
}

