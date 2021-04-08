//
//  SocialUITests.swift
//  MarketManiaUITests
//
//  Created by Connor Hanson on 4/7/21.
//

import XCTest

class SocialUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSocialViewsExist() throws {
        //check that the head exists
        XCTAssert(app.staticTexts["SocialLeaderboardHead"].exists)

        //check that fields with user info exist
        XCTAssert(app.otherElements["UsersListView"].exists)
        XCTAssert(app.otherElements["usersListCell"].exists)
        
        //check that the labels exist
        XCTAssert(app.otherElements["userListLabel"].exists)
        XCTAssert(app.otherElements["userListRank"].exists)
        XCTAssert(app.otherElements["userListRank"].exists)
        XCTAssert(app.otherElements["collectionView2"].exists)
        XCTAssert(app.otherElements["leaderboardLabel"].exists)
        XCTAssert(app.otherElements["userNameLabel"].exists)
        XCTAssert(app.otherElements["tempSarcasticLabel"].exists)

        

        
    }

}
