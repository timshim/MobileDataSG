//
//  MobileDataViewModel.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import Foundation

final class MobileDataViewModel {

    var govDataService: GovDataService

    let screenTitle = "Mobile Data Usage"
    var dataRecords: [DataRecord] = [] {
        didSet {
            parseRecords(records: dataRecords)
        }
    }
    var yearlyRecords: [YearlyRecord] = []
    var maxVolume: Double = 0

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

    private func parseRecords(records: [DataRecord]) {
        var recordsInYears = [Int: Double]()
        for record in records {
            guard let year = record.getYear() else { return }
            let volume = record.volume

            if recordsInYears[year] != nil {
                guard let currentVolume = recordsInYears[year] else { return }
                let newVolume = currentVolume + volume
                recordsInYears[year] = round(newVolume * 1_000_000) / 1_000_000
            } else {
                recordsInYears[year] = volume
            }
        }

        var yearlyRecordsArray = [YearlyRecord]()
        for record in recordsInYears {
            let yearlyRecord = YearlyRecord(year: record.key, totalVolume: record.value)
            yearlyRecordsArray.append(yearlyRecord)

            if record.value > maxVolume {
                self.maxVolume = record.value
            }
        }

        yearlyRecordsArray.sort {  $0.year < $1.year }

        self.yearlyRecords = yearlyRecordsArray
    }
    
}
