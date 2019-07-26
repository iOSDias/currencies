//
//  UINavigationBarExtension.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    // MARK: - Methods
    func setTransparent(_ transparent: Bool) {
        if #available(iOS 11.0, *) {
            isTranslucent = transparent
        } else {
            isTranslucent = false
        }
        
        setBackgroundImage(transparent ? UIImage() : nil, for: .default)
    }
}
