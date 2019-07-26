//
//  BaseCurrencyRouter.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

class BaseCurrencyRouter: RouterProtocol {
    
    // MARK: - Enums
    enum PresentationContext {
        case `default`
    }
    
    enum RouteType {
        case convertCurrencySelection(baseCurrency: Currency)
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
        case .default:
            let viewController = BaseCurrencyViewController()
            viewController.router = self
            DispatchQueue.main.async {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
    }
    
    func enqueueRoute(with context: Any?, animated: Bool) {
        guard let routeType = context as? RouteType else {
            assertionFailure("The route type mismatch")
            return
        }
        
        guard let baseVC = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .convertCurrencySelection(let baseCurrency):
            let router = ConvertCurrencyRouter()
            let context = ConvertCurrencyRouter.PresentationContext.default(baseCurrency: baseCurrency)
            router.present(on: baseVC, animated: animated, context: context)
        }
    }
    
    func dismiss(animated: Bool) {
        guard let baseVC = baseViewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        guard let navigationController = baseVC.navigationController else {
            assertionFailure("Navigation controller is not set")
            return
        }
        
        navigationController.popViewController(animated: true)
    }
}
