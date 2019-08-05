//
//  MobileDataViewModel.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

final class MobileDataViewModel {

    let screenTitle = "Mobile Data Usage"
    var dataRecords: [DataRecord] = []

    func fetchMobileUsageData(completion: @escaping (Error?) -> Void) {
        GovDataService.fetchData(resource: .mobileDataUsage) { [weak self] (dataRecords, error) in
            if let error = error {
                completion(error)
            }
            self?.dataRecords = dataRecords
            completion(nil)
        }
    }
    
}
