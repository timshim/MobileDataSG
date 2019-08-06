//
//  MobileDataViewModel.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

final class MobileDataViewModel {

    let screenTitle = "Mobile Data Usage"
    var dataRecords: [DataRecord] = [] {
        didSet {
            
        }
    }
    var govDataService: GovDataService

    init(govDataService: GovDataService) {
        self.govDataService = govDataService
    }

    func fetchMobileUsageData(completion: @escaping (ErrorProtocol?) -> Void) {
        govDataService.fetchData(resource: .mobileDataUsage) { [weak self] (dataRecords, error) in
            if let error = error {
                completion(error)
            }
            self?.dataRecords = dataRecords
            completion(nil)
        }
    }
    
}
