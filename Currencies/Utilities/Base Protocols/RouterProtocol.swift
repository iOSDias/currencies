//
//  RouterProtocol.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

protocol RouterProtocol: class {
    // MARK: - Properties
    var baseViewController: UIViewController? { get set }
    
    // MARK: - Methods
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?)
    func enqueueRoute(with context: Any?, animated: Bool)
    func dismiss(animated: Bool)
}

extension RouterProtocol {
    
    // MARK: - Router default methods
    func present(on baseViewController: UIViewController, context: Any?) {
        present(on: baseViewController, animated: true, context: context)
    }
    
    func enqueueRoute(with context: Any?) {
        enqueueRoute(with: context, animated: true)
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
}
