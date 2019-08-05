//
//  NetworkingService.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

final class NetworkingService {

    enum HTTPMethod: String {
        case GET, POST, PUT, PATCH, DELETE
    }
    enum NetworkingError: Error {
        case requestError(message: String), jsonError
    }

    static func request(url: URL, httpMethod: HTTPMethod, params: [String: Any], completion: @escaping (Any?, Error?) -> Void) {
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = httpMethod.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, NetworkingError.requestError(message: error.localizedDescription))
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(json, nil)
                } catch {
                    completion(nil, NetworkingError.jsonError)
                }
            } else {
                completion(nil, nil)
            }
            }.resume()
    }

}
