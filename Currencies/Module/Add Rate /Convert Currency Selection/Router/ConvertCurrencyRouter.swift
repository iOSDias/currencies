//
//  ConvertCurrencyRouter.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

class ConvertCurrencyRouter: RouterProtocol {
    
    // MARK: - Enums
    enum PresentationContext {
        case `default`(baseCurrency: Currency)
    }
    
    // MARK: - Properties
    weak var baseViewController: UIViewController?
    
    // MARK: - Methods
    func present(on baseVC: UIViewController, animated: Bool, context: Any?) {
        guard let context = context as? PresentationContext else {
            assertionFailure("The context type mismatch")
            return
        }
        
        guard let navigationController = baseVC.navigationController else {
            assertionFailure("Navigation controller is not set")
            return
        }
        
        baseViewController = baseVC
        
        switch context {
        case .default(let baseCurrency):
            let viewController = ConvertCurrencyViewController()
            viewController.router = self
            viewController.baseCurrency = baseCurrency
            DispatchQueue.main.async {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool) {}
    
    func dismiss(animated: Bool) {
        guard let baseVC = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        guard let navigationController = baseVC.navigationController else {
            assertionFailure("Navigation controller is not set")
            return
        }
        
        navigationController.popToRootViewController(animated: true)
    }
}
