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
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        //navigate to Social page
        let social = app.tabBars.buttons["Social"]
        social.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //test  SocialLeaderboardHead.swift
    func testSocialLeaderboardHead() throws {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let leaderboards = collectionViewsQuery.cells.staticTexts["Leaderboards"]
        let sarcasticLabel = collectionViewsQuery.cells.staticTexts["Money talks but yours just says good-bye"]
        
        //make sure the static labels in WelcomeView.swift exist
        XCTAssertTrue(leaderboards.exists)
        XCTAssertTrue(sarcasticLabel.exists)
        
        
        
    }
    
    //test to make sure the collection has labels and is vertically scrollable
    func testCollection() throws {

        
        let rank = app.staticTexts["Rank"]
        let name = app.staticTexts["Name"]
        
        
        let vCV = app.collectionViews.cells.collectionViews.containing(.cell, identifier: "leaderboard")
        
        //check if leaderboard collection view is scrollable
        vCV.children(matching: .cell).element(boundBy: 0).swipeUp()
        vCV.children(matching: .cell).element(boundBy: 2).swipeDown()

        //check if name and rank labels exist
        XCTAssertTrue(rank.exists)
        XCTAssertTrue(name.exists)
        

    }

}
