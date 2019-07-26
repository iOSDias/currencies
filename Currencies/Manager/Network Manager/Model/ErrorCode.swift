//
//  ErrorCode.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

enum ErrorCode: Int {
    
    case fourZeroFour = 404
    case oneZeroOne = 101
    case oneZeroTwo = 102
    case oneZeroThree = 103
    case oneZeroFour = 104
    case oneZeroFive = 105
    case oneZeroSix = 106
    case twoZeroOne = 201
    case twoZeroTwo = 202
    case server
    case noInternetConnection

    var message: String {
        switch self {
        case .fourZeroFour: return "The requested resource does not exist"
        case .oneZeroOne: return "No API Key was specified or an invalid API Key was specified"
        case .oneZeroTwo: return "The account this API request is coming from is inactive"
        case .oneZeroThree: return "The requested API endpoint does not exist"
        case .oneZeroFour: return "The maximum allowed API amount of monthly API requests has been reached"
        case .oneZeroFive: return "The current subscription plan does not support this API endpoint."
        case .oneZeroSix: return "The current request did not return any results"
        case .twoZeroOne: return "An invalid base currency has been entered"
        case .twoZeroTwo: return "One or more invalid symbols have been specified"
        case .server: return "Server error"
        case .noInternetConnection: return "No Internet connection"
        }
    }
}
