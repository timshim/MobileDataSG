//
//  DataRecord.swift
//  MobileDataSG
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

struct DataRecord {

    var quarter: String
    var volume: Double

    func getYear() -> Int? {
        guard let yearString = quarter.split(separator: "-").first else { return nil }
        return Int(yearString)
    }

}
