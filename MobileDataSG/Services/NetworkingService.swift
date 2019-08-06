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

enum NetworkingError: Error {
    case requestError(message: String), jsonError(message: String)
}

protocol NetworkingServiceProtocol {
    func request(url: URL, httpMethod: HTTPMethod, params: [String: Any], completion: @escaping (Any?, Error?) -> Void)
}

final class NetworkingService: NetworkingServiceProtocol {

    func request(url: URL, httpMethod: HTTPMethod, params: [String: Any], completion: @escaping (Any?, Error?) -> Void) {
        var mutableUrl = url
        mutableUrl = mutableUrl.appendingQueryParameters(params)
        
        var request = URLRequest(url: mutableUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = httpMethod.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, NetworkingError.requestError(message: error.localizedDescription))
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json, nil)
                } catch (let error) {
                    completion(nil, NetworkingError.jsonError(message: error.localizedDescription))
                }
            }
        }.resume()
    }

}
