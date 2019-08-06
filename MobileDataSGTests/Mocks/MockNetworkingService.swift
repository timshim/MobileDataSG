//
//  MockNetworkingService.swift
//  MobileDataSGTests
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit
@testable import MobileDataSG

final class MockNetworkingService: NetworkingServiceProtocol {

    var returnsError = false

    func request(url: URL, httpMethod: HTTPMethod, params: [String : Any], completion: @escaping (Any?, Error?) -> Void) {
        if returnsError {
            let error = NetworkingError.requestError(message: "Request error")
            completion(nil, error)
            return
        }

        let json: Any = [
            "help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search",
            "success": true,
            "result": [
                "resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f",
                "fields": [
                    ["type": "text", "id": "quarter"], ["type": "numeric", "id": "volume_of_mobile_data"]
                ],
                "records": [
                    ["volume_of_mobile_data": "0.171586", "quarter": "2008-Q1"],
                    ["volume_of_mobile_data": "0.248899", "quarter": "2008-Q2"],
                    ["volume_of_mobile_data": "0.439655", "quarter": "2008-Q3"],
                    ["volume_of_mobile_data": "0.683579", "quarter": "2008-Q4"],
                    ["volume_of_mobile_data": "1.066517", "quarter": "2009-Q1"],
                    ["volume_of_mobile_data": "1.357248", "quarter": "2009-Q2"],
                    ["volume_of_mobile_data": "1.695704", "quarter": "2009-Q3"],
                    ["volume_of_mobile_data": "2.109516", "quarter": "2009-Q4"],
                    ["volume_of_mobile_data": "2.3363", "quarter": "2010-Q1"],
                    ["volume_of_mobile_data": "2.777817", "quarter": "2010-Q2"],
                    ["volume_of_mobile_data": "3.002091", "quarter": "2010-Q3"],
                    ["volume_of_mobile_data": "3.336984", "quarter": "2010-Q4"],
                    ["volume_of_mobile_data": "3.466228", "quarter": "2011-Q1"],
                    ["volume_of_mobile_data": "3.380723", "quarter": "2011-Q2"],
                    ["volume_of_mobile_data": "3.713792", "quarter": "2011-Q3"],
                    ["volume_of_mobile_data": "4.07796", "quarter": "2011-Q4"],
                    ["volume_of_mobile_data": "4.679465", "quarter": "2012-Q1"],
                    ["volume_of_mobile_data": "5.331562", "quarter": "2012-Q2"],
                    ["volume_of_mobile_data": "5.614201", "quarter": "2012-Q3"],
                    ["volume_of_mobile_data": "5.903005", "quarter": "2012-Q4"],
                    ["volume_of_mobile_data": "5.807872", "quarter": "2013-Q1"],
                    ["volume_of_mobile_data": "7.053642", "quarter": "2013-Q2"],
                    ["volume_of_mobile_data": "7.970536", "quarter": "2013-Q3"],
                    ["volume_of_mobile_data": "7.664802", "quarter": "2013-Q4"],
                    ["volume_of_mobile_data": "7.73018", "quarter": "2014-Q1"],
                    ["volume_of_mobile_data": "7.907798", "quarter": "2014-Q2"],
                    ["volume_of_mobile_data": "8.629095", "quarter": "2014-Q3"],
                    ["volume_of_mobile_data": "9.327967", "quarter": "2014-Q4"],
                    ["volume_of_mobile_data": "9.687363", "quarter": "2015-Q1"],
                    ["volume_of_mobile_data": "9.98677", "quarter": "2015-Q2"],
                    ["volume_of_mobile_data": "10.902194", "quarter": "2015-Q3"],
                    ["volume_of_mobile_data": "10.677166", "quarter": "2015-Q4"],
                    ["volume_of_mobile_data": "10.96733", "quarter": "2016-Q1"],
                    ["volume_of_mobile_data": "11.38734", "quarter": "2016-Q2"],
                    ["volume_of_mobile_data": "12.14232", "quarter": "2016-Q3"],
                    ["volume_of_mobile_data": "12.86429", "quarter": "2016-Q4"],
                    ["volume_of_mobile_data": "13.29757", "quarter": "2017-Q1"],
                    ["volume_of_mobile_data": "14.54179", "quarter": "2017-Q2"],
                    ["volume_of_mobile_data": "14.88463", "quarter": "2017-Q3"],
                    ["volume_of_mobile_data": "15.77653", "quarter": "2017-Q4"]
                ],
                "limit": 40,
                "offset": 14,
                "_links": [
                    "start": "/api/action/datastore_search?fields=quarter%2C+volume_of_mobile_data&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=40",
                    "next": "/api/action/datastore_search?fields=quarter%2C+volume_of_mobile_data&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=40&offset=54"
                ],
                "total": 56
            ]
        ]

        completion(json, nil)
    }

}
