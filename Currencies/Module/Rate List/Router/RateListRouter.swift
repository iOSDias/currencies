//
//  RateListRouter.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

class RateListRouter: RouterProtocol {
    
    // MARK: - Enums
    enum RouteType {
        case addRate
    }
    
    // MARK: - Properties
    weak var baseViewController: UIViewController?
    
    // MARK: - Methods
    func present(on baseVC: UIViewController, animated: Bool, context: Any?) { }
    
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
        case .addRate:
            let router = BaseCurrencyRouter()
            let context = BaseCurrencyRouter.PresentationContext.default
            router.present(on: baseVC, animated: animated, context: context)
        }
    }
    
    func dismiss(animated: Bool) { }
}
