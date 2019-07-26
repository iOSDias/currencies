//
//  JSONResult.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

enum JSONResult {
    case success(JSON)
    case failed(String)
}
