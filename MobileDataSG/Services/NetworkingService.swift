//
//  NetworkingService.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol ErrorProtocol: LocalizedError {
    var message: String? { get }
}

struct NetworkingError: ErrorProtocol {
    var message: String?

    init(message: String) {
        self.message = message
    }
}

protocol NetworkingServiceProtocol {
    func request(url: URL, httpMethod: HTTPMethod, params: [String: Any], completion: @escaping (Any?, ErrorProtocol?) -> Void)
}

final class NetworkingService: NetworkingServiceProtocol {

    func request(url: URL, httpMethod: HTTPMethod, params: [String: Any], completion: @escaping (Any?, ErrorProtocol?) -> Void) {
        var mutableUrl = url
        mutableUrl = mutableUrl.appendingQueryParameters(params)
        
        var request = URLRequest(url: mutableUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = httpMethod.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                let requestError = NetworkingError(message: "Request error")
                completion(nil, requestError)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json, nil)
                } catch {
                    let jsonError = NetworkingError(message: "JSON serialization error")
                    completion(nil, jsonError)
                }
            }
        }.resume()
    }

}
