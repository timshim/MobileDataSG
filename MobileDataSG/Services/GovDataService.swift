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
    typealias RecordsResponse = ([[String: Any]], Error?) -> Void

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
    }

}
