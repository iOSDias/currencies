//
//  URL.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import UIKit

extension URL {
    
    // MARK: - Properties
    private static var serverURL: String { return Environment.current.serverURL }
    
    static func latestRates(access_key: String, base: String, symbols: String) -> URL {
        return URL(string: serverURL + "latest?access_key=\(access_key)&base=\(base)&symbols=\(symbols)")!
    }
    static func symbols(access_key: String) -> URL {
        return URL(string: serverURL + "symbols?access_key=\(access_key)")!
    }
}
