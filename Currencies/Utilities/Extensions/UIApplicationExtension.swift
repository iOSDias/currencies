//
//  UIApplicationExtension.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension UIApplication {
    
    // MARK: - Properties
    var window: UIWindow {
        guard let window = windows.first else {
            return UIWindow(frame: UIScreen.main.bounds)
        }
        
        return window
    }
}
