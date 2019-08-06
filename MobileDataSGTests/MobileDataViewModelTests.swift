//
//  MobileDataViewModelTests.swift
//  MobileDataSGTests
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import XCTest
@testable import MobileDataSG

class MobileDataViewModelTests: XCTestCase {

    var sut: MobileDataViewModel!
    var mockNetworkingService: MockNetworkingService!
    var govDataService: GovDataService!

    override func setUp() {
        super.setUp()
        mockNetworkingService = MockNetworkingService()
        govDataService = GovDataService(networkingService: mockNetworkingService)
        sut = MobileDataViewModel(govDataService: govDataService)
    }

    override func tearDown() {
        sut = nil
        mockNetworkingService = nil
        govDataService = nil
        super.tearDown()
    }

    func test_screenTitle_isCorrect() {
        XCTAssertEqual(sut.screenTitle, "Mobile Data Usage")
    }

    func test_fetchMobileUsageData_returnsDataRecords() {
        sut.fetchMobileUsageData { error in
            XCTAssertNil(error)
            XCTAssertFalse(self.sut.dataRecords.isEmpty)
        }
    }

    func test_fetchMobileUsageData_returnsError() {
        mockNetworkingService.returnsError = true
        sut.fetchMobileUsageData { (error) in
            XCTAssertNotNil(error)
        }
    }

}
