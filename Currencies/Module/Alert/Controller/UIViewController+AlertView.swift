//
//  UIViewController+AlertView.swift
//  UMAG
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias. All rights reserved.
//

import SwiftEntryKit
import UIKit

extension UIViewController {
    
    // MARK: - Methods
    func showAlert(with message: String, backgroundColor: UIColor) {
        var attributes = EKAttributes.topToast
        attributes.entryBackground = .color(color: backgroundColor)
        attributes.positionConstraints.size = .init(width: .fill, height: .intrinsic)
        attributes.displayDuration = 2
        attributes.entryInteraction = .absorbTouches
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        
        let customView = AlertView(message: message)
        SwiftEntryKit.display(entry: customView, using: attributes)
    }
    
}
