//
//  NetworkManager.swift
//  Currencies
//
//  Created by Dias Ermekbaev on 7/26/19.
//  Copyright © 2019 Dias Yermekbayev. All rights reserved.
//

import Alamofire
import Reachability

protocol NetworkManagerProtocol: class {
    
    func send(request: URLRequest, completionHandler: ((JSONResult) -> Void)?)
    func request(_ url: URL, method: HTTPMethod, headers: HTTPHeaders?, parameters: Any?, timeoutInterval: TimeInterval,
                 completionHandler: ((JSONResult) -> Void)?)
}

extension NetworkManagerProtocol {
    
    func request(_ url: URL, method: HTTPMethod, headers: HTTPHeaders? = nil, parameters: Any? = nil, timeoutInterval: TimeInterval = 60,
                 completionHandler: ((JSONResult) -> Void)?) {
        request(url, method: method, headers: headers, parameters: parameters, timeoutInterval: timeoutInterval, completionHandler: completionHandler)
    }
    
}

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    static let shared: NetworkManagerProtocol = NetworkManager()
    private lazy var dataResponseManager: DataResponseManagerProtocol = DataResponseManager()
    
    func send(request: URLRequest, completionHandler: ((JSONResult) -> Void)?) {
        guard let connection = Reachability()?.connection, !(connection == .none) else {
            completionHandler?(.failed("Отсутствует интернет соединение"))
            return
        }
        
        guard let url = request.url else {
            assertionFailure("DESCIPRION: URL of request is nil\nREQUEST: \(request)")
            completionHandler?(.failed("Ошибка сервера"))
            return
        }
        
        Alamofire.request(request).responseJSON { [weak self] response in
            guard let `self` = self else { return }
            self.printResponse(response)
            
            self.dataResponseManager.process(url: url, response: response, completionHandler: completionHandler)
        }
    }
    
    private func getConfiguredRequest(_ request: URLRequest, url: URL, method: HTTPMethod, parameters: Any?) -> URLRequest {
        var configuredRequest = request
        if let parameters = parameters as? Parameters {
            do {
                switch method {
                case .get: configuredRequest = try URLEncoding.default.encode(request, with: parameters)
                default: configuredRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])
                }
            } catch {
                assertionFailure("DESCRIPTION: Encoding error\nURL: \(url)\nERROR: \(error.localizedDescription)\n")
            }
        } else if let parameters = parameters as? [Parameters] {
            do {
                var signature = ""
                for (index, parameter) in parameters.enumerated() {
                    signature += parameter.sorted { first, second -> Bool in
                        return first.key < second.key
                        }.reduce("") { result, parameter -> String in
                            if let bool = parameter.value as? Bool {
                                return "\(result)\(index)[\(parameter.key)]=\(bool ? 1 : 0)"
                            } else {
                                return "\(result)\(index)[\(parameter.key)]=\(parameter.value)"
                            }
                    }
                }
                
                configuredRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])
            } catch {
                assertionFailure("DESCRIPTION: Encoding error\nURL: \(url)\nERROR: \(error.localizedDescription)\n")
            }
        } else if let parameters = parameters as? [Any] {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let parameterString = String(data: data, encoding: .utf8)
                configuredRequest.httpBody = parameterString?.data(using: .utf8)
            } catch {
                assertionFailure("DESCRIPTION: Encoding error\nURL: \(url)\nERROR: \(error.localizedDescription)\n")
            }
        }
        
        return configuredRequest
    }
    
    
    private func getRequest(url: URL, method: HTTPMethod, headers: HTTPHeaders?, parameters: Any?, timeoutInterval: TimeInterval) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval
        (headers ?? [:]).forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return getConfiguredRequest(request, url: url, method: method, parameters: parameters)
    }
    
    func request(_ url: URL, method: HTTPMethod, headers: HTTPHeaders?, parameters: Any?, timeoutInterval: TimeInterval,
                 completionHandler: ((JSONResult) -> Void)?) {
        
        let request = getRequest(url: url, method: method, headers: headers, parameters: parameters, timeoutInterval: timeoutInterval)
        send(request: request, completionHandler: completionHandler)
    }
    
}


extension NetworkManager {
    
    // MARK: - Print response
    private func printResponse(_ response: DataResponse<Any>) {
        for _ in 0..<10 { print() }
        for _ in 0..<150 { print("-", separator: "", terminator: "") }
        print()
        print("[Headers]: \(response.request?.allHTTPHeaderFields ?? [:])")
        print("[Request]: \(response.request?.httpMethod ?? "") \(response.response?.url?.absoluteString ?? "")")
        if let data = response.request?.httpBody {
            do {
                print("[Parameters]: \(try JSONSerialization.jsonObject(with: data))")
            } catch {
                print("[Parameters]: \([:])")
            }
        } else {
            print("[Parameters]: \([:])")
        }
        
        if let data = response.data {
            guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
                let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let dataString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
            
            print("[Result]: \(dataString)")
        }
        
        for _ in 0..<150 { print("-", separator: "", terminator: "") }
        for _ in 0..<10 { print() }
    }
    
}
