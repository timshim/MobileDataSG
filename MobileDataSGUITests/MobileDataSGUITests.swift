//
//  MobileDataSGUITests.swift
//  MobileDataSGUITests
//
//  Created by Tim Shim on 8/6/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import XCTest
@testable import MobileDataSG

class MobileDataSGUITests: XCTestCase {

    var sut: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        sut = XCUIApplication()
        sut.launch()

        let activityIndicator = sut.collectionViews.activityIndicators["In progress"]
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: activityIndicator, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_navTitle_exists() {
        XCTAssertTrue(sut.navigationBars["Mobile Data Usage"].otherElements["Mobile Data Usage"].exists)
    }

    func test_collectionView_has10cells() {
        let collectionCells = sut.collectionViews.children(matching: .cell)
        XCTAssertEqual(collectionCells.count, 9)
    }

    func test_collectionViewCells_include2labels() {
        let collectionViewsQuery = sut.collectionViews
        for index in 0..<collectionViewsQuery.cells.count {
            let element = collectionViewsQuery.cells.element(boundBy: index)
            XCTAssertEqual(element.staticTexts.count, 2)
        }
    }

    func test_collectionViewCells_containsFillView() {
        let collectionViewsQuery = sut.collectionViews
        for index in 0..<collectionViewsQuery.cells.count {
            let element = collectionViewsQuery.cells.element(boundBy: index).otherElements["fillView"]
            XCTAssertTrue(element.exists)
        }
    }

    func test_collectionViewCells_357ContainsInfoButton() {
        let collectionViewsQuery = sut.collectionViews
        let cell3InfoButton = collectionViewsQuery.cells.element(boundBy: 3).buttons["infoButton"]
        let cell5InfoButton = collectionViewsQuery.cells.element(boundBy: 5).buttons["infoButton"]
        let cell7InfoButton = collectionViewsQuery.cells.element(boundBy: 7).buttons["infoButton"]

        XCTAssertTrue(cell3InfoButton.exists)
        XCTAssertTrue(cell5InfoButton.exists)
        XCTAssertTrue(cell7InfoButton.exists)
    }

    func test_collectionViewCells_0124689ContainsInfoButton() {
        let collectionViewsQuery = sut.collectionViews
        let cell0InfoButton = collectionViewsQuery.cells.element(boundBy: 0).buttons["infoButton"]
        let cell1InfoButton = collectionViewsQuery.cells.element(boundBy: 1).buttons["infoButton"]
        let cell2InfoButton = collectionViewsQuery.cells.element(boundBy: 2).buttons["infoButton"]
        let cell4InfoButton = collectionViewsQuery.cells.element(boundBy: 4).buttons["infoButton"]
        let cell6InfoButton = collectionViewsQuery.cells.element(boundBy: 6).buttons["infoButton"]
        let cell8InfoButton = collectionViewsQuery.cells.element(boundBy: 8).buttons["infoButton"]
        let cell9InfoButton = collectionViewsQuery.cells.element(boundBy: 9).buttons["infoButton"]

        XCTAssertFalse(cell0InfoButton.exists)
        XCTAssertFalse(cell1InfoButton.exists)
        XCTAssertFalse(cell2InfoButton.exists)
        XCTAssertFalse(cell4InfoButton.exists)
        XCTAssertFalse(cell6InfoButton.exists)
        XCTAssertFalse(cell8InfoButton.exists)
        XCTAssertFalse(cell9InfoButton.exists)
    }

    func test_infoButton_tapShowsAlert() {
        sut.collectionViews.children(matching: .cell).element(boundBy: 3)/*@START_MENU_TOKEN@*/.buttons["infoButton"]/*[[".buttons[\"image button\"]",".buttons[\"infoButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let alert = sut.alerts["Info"].buttons["OK"]
        XCTAssertTrue(alert.exists)
    }

    func test_activityIndicator_isRemovedWhenDataLoaded() {
        let activityIndicator = sut.collectionViews.activityIndicators["In progress"]
        XCTAssertFalse(activityIndicator.exists)
    }

}
