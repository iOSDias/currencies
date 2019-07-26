//
//  Environment.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import Foundation

enum Environment {
    
    // MARK: - Cases
    case development, test, production
    
    // MARK: - Properties
    static var current: Environment = .development
    
    var serverURL: String {
        switch self {
        case .development:          return "http://data.fixer.io/api/"
        case .test:                 return "http://data.fixer.io/api/"
        case .production:           return "http://data.fixer.io/api/"
        }
    }
    
    static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    static var appStoreId: String {
        return ""
    }
}
