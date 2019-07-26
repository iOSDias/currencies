//
//  UILabelExtension.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension UILabel {
    
    // MARK: - Methods
    func isMoreThanOneLine(width: CGFloat) -> Bool {
        guard let text = text else { return false }
        
        let oneLineHeight = ceil(font.lineHeight)
        let currentHeight = text.height(withConstrainedWidth: width, font: font)
        return currentHeight > oneLineHeight
    }
}
