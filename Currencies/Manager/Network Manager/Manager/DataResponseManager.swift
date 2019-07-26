//
//  DataResponseManager.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import Alamofire

protocol DataResponseManagerProtocol: class {
    func process(url: URL, response: DataResponse<Any>, completionHandler: ((JSONResult) -> Void)?)
}

class DataResponseManager: DataResponseManagerProtocol {
    
    // MARK: - Methods
    private func process(json: JSON, url: URL, response: DataResponse<Any>, completionHandler: ((JSONResult) -> Void)? = nil) {
        guard let success = json["success"] as? Bool else {
            completionHandler?(.failed(ErrorCode.server.message))
            return 
        }
        
        if success {
            completionHandler?(.success(json))
        } else {
            var result: ErrorCode = .server
            if let error = json["error"] as? JSON, let code = error["code"] as? Int, let errorCode = ErrorCode(rawValue: code) {
                result = errorCode
            }
            completionHandler?(.failed(result.message))
        }
    }
    
    func process(url: URL, response: DataResponse<Any>, completionHandler: ((JSONResult) -> Void)? = nil) {
        switch response.result {
        case .success(let value):
            guard let json = value as? JSON else {
                assertionFailure("DESCRIPTION: JSON parsing error\nURL: \(url)\nValue=\(value)\n")
                completionHandler?(.failed(ErrorCode.server.message))
                return
            }
            
            process(json: json, url: url, response: response, completionHandler: completionHandler)
        case .failure(let error):
            completionHandler?(.failed(error.localizedDescription))
        }
    }
    
}
