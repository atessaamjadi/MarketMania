//
//  HomeUITests.swift
//  MarketManiaUITests
//
//  Created by Connor Hanson on 4/7/21.
//

import XCTest

@testable import MarketMania

class HomeUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    //test WelcomeView.swift
    func testWelcomeView() throws {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let welcomeBackLabel = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Welcome back "]/*[[".cells.staticTexts[\"Welcome back \"]",".staticTexts[\"Welcome back \"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let sarcasticLabel = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Ready to lose more $ ?"]/*[[".cells.staticTexts[\"Ready to lose more $ ?\"]",".staticTexts[\"Ready to lose more $ ?\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        
        //make sure the static labels in WelcomeView.swift exist
        XCTAssertTrue(welcomeBackLabel.exists)
        XCTAssertTrue(sarcasticLabel.exists)
        
        
        
    }
    //test to make sure topMoviesView has label and is horizontally scrollable
    func testTopMovesView() throws {

        let collectionViewsQuery = XCUIApplication().collectionViews
        let todaysWinnerLabel = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Today's Winners"]/*[[".cells.staticTexts[\"Today's Winners\"]",".staticTexts[\"Today's Winners\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        
        
        let hCV = app.collectionViews.cells.collectionViews.containing(.cell, identifier: "mover")
        
        //checks if it counts greater than or = to 6 with 2 slides (since this is our default) number of cells
        hCV.children(matching: .cell).element(boundBy: 0).swipeLeft()
        var count = hCV.children(matching: .cell).count
        hCV.children(matching: .cell).element(boundBy: 2).swipeLeft()
        count += hCV.children(matching: .cell).count
        
     
        XCTAssertGreaterThanOrEqual(count, 6)
        XCTAssertTrue(todaysWinnerLabel.exists)
        

    }
    
    //tests if stock detail elements are present
    func testTopMovesStockDetailView() throws {
        
        //click on a mover cell
        XCUIApplication().collectionViews.cells.collectionViews.containing(.cell, identifier: "mover").element.tap()
        
        XCTAssert(app.staticTexts["nl"].exists)
        XCTAssert(app.buttons["ss"].exists)
        XCTAssert(app.staticTexts["sl"].exists)
        XCTAssert(app.textViews["tv"].exists)
        XCTAssert(app.buttons["tb"].exists)
        
        //XCTAssert(app.buttons["atwl"].exists)
        
    }
    
    //TODO: uncomment test below when watch list is visible again
    
    //tests scroll function of watchList and label
//    func testWatchList() throws {
//
//        let collectionViewsQuery = XCUIApplication().collectionViews
//        let watchListLabel = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Watchlist"]/*[[".cells.staticTexts[\"Watchlist\"]",".staticTexts[\"Watchlist\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//
//
//        let horizontalScrollBar1PageCollectionViewsQuery = XCUIApplication().collectionViews.cells.collectionViews.containing(.other, identifier:"Horizontal scroll bar, 1 page")
//        horizontalScrollBar1PageCollectionViewsQuery.children(matching: .cell).element(boundBy: 0).swipeUp()
//        horizontalScrollBar1PageCollectionViewsQuery.children(matching: .cell).element(boundBy: 2).swipeDown()
//
//        XCTAssertTrue(watchListLabel.exists)
//
//    }
    
}
