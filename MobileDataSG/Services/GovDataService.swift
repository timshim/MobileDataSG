//
//  GovDataService.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

final class GovDataService {

    enum DataResource: String {
        case mobileDataUsage = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    }
    typealias RecordsResponse = ([DataRecord], Error?) -> Void

    private static let endpoint = "https://data.gov.sg/api/action/datastore_search"
    private static let offset = 14
    private static let fields = ["quarter", "volume_of_mobile_data"]
    private static let limit = 40

    static func fetchData(resource: DataResource, completion: @escaping RecordsResponse) {
        guard let url = URL(string: endpoint) else { return }
        let params = [
            "resource_id": resource.rawValue,
            "offset": "\(offset)",
            "fields": fields.joined(separator: ","),
            "limit": "\(limit)",
        ]

        NetworkingService.request(url: url, httpMethod: .GET, params: params) { (json, error) in
            guard let json = json as? [String: Any] else { return }
            guard let success = json["success"] as? Bool, success == true else { return }
            guard let result = json["result"] as? [String: Any] else { return }
            guard let records = result["records"] as? [[String: Any]] else { return }

            var dataRecords: [DataRecord] = []

            for record in records {
                guard let quarter = record["quarter"] as? String else { return }
                guard let volumeString = record["volume_of_mobile_data"] as? String else { return }
                guard let volume = Double(volumeString) else { return }
                let dataRecord = DataRecord(quarter: quarter, volume: volume)
                dataRecords.append(dataRecord)
            }

            completion(dataRecords, error)
        }
    }

}
