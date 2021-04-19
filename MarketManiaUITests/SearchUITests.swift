//
//  SearchUITests.swift
//  MarketManiaUITests
//
//  Created by Connor Hanson on 4/7/21.
//

import XCTest

class SearchUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        //navigate to the search page
        let searchPage = app.tabBars.buttons["Search"]
        searchPage.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //testing the UI of the search bar and it's respective text field
    func testSearch() throws {

        
        //click in the search textField
        
        let searchField = app.searchFields.containing(.searchField, identifier: "stf").element
        searchField.tap()
        
        //make sure you can type text
        searchField.typeText("Apple")
        
        //since end text and cancel button are built into the searchBar UI, not testing this since the elements are difficult to find
        
    }
    
    //tests that most popular collection view exists and is horizontally scrollable
    func testMostPopular() throws{
        
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let mostPopularLabel = collectionViewsQuery.cells.staticTexts["Most popular"]
        
        
        let hCV = app.collectionViews.cells.collectionViews.containing(.cell, identifier: "popular")
        
        //checks if it counts greater than or = to 6 with 2 slides (since this is our default) number of cells
        hCV.children(matching: .cell).element(boundBy: 0).swipeLeft()
        var count = hCV.children(matching: .cell).count
        hCV.children(matching: .cell).element(boundBy: 2).swipeLeft()
        count += hCV.children(matching: .cell).count
        
     
        XCTAssertGreaterThanOrEqual(count, 6)
        XCTAssertTrue(mostPopularLabel.exists)
    }
    
    func testSectors() throws {
        
     
        let sectorsLabel = app.staticTexts["Sectors"]
        
        let vCV = app.collectionViews.cells.collectionViews.containing(.cell, identifier: "sector")
                
        //checks if it counts greater than or = to 6 with 2 slides (since this is our default) number of cells
        vCV.children(matching: .cell).element(boundBy: 0).swipeUp()
        var count = vCV.children(matching: .cell).count
        vCV.children(matching: .cell).element(boundBy: 2).swipeDown()
        count += vCV.children(matching: .cell).count
        
        
        XCTAssertTrue(sectorsLabel.exists)
        XCTAssertGreaterThanOrEqual(count, 6)
    
    }
    
    //check if sectorCategoryVC is scrollable and contains expected elements
    func testSectorCategoryCells() throws {
        
        let vCV = app.collectionViews.cells.collectionViews.containing(.cell, identifier: "sector")
        
        //click on a sector cell
        vCV.element.tap()
        
        let category = app.staticTexts["scl"]
        
        let singleCell = app.collectionViews.containing(.cell, identifier: "categoryCell")
                
        //checks if scrollable
        singleCell.children(matching: .cell).element(boundBy: 0).swipeUp()
        singleCell.children(matching: .cell).element(boundBy: 2).swipeDown()
        
        
        //check if unexpanded cell expected elements exist
        
        let name = app.staticTexts["name"]
        let perc = app.staticTexts["perc"]
        let price = app.staticTexts["price"]
        let curr = app.staticTexts["curr"]
        
        
        XCTAssertTrue(category.exists)
        XCTAssertTrue(name.exists)
        XCTAssertTrue(perc.exists)
        XCTAssertTrue(price.exists)
        XCTAssertTrue(curr.exists)
    
    }
    
    
    //check if sector category cell stock detail view contains all expected elements
    func testCategoryCellStockDetail() throws {
        
        
        //click on a mover cell
        app.collectionViews.cells.collectionViews.containing(.cell, identifier: "sector").element.tap()
        
        //click on a sector category cell
        app.collectionViews.cells.containing(.staticText, identifier: "name").element(boundBy: 0).tap()

        //check if stock detail elements exist
        XCTAssert(app.staticTexts["nl"].exists)
        XCTAssert(app.buttons["ss"].exists)
        XCTAssert(app.staticTexts["sl"].exists)
        XCTAssert(app.textViews["tv"].exists)
        XCTAssert(app.buttons["tb"].exists)
        XCTAssert(app.buttons["atwl"].exists)
            
    }
    
    //test SectorCategoryVC search
    func testCategorySearch() throws {
        
        //click on a mover cell
        app.collectionViews.cells.collectionViews.containing(.cell, identifier: "sector").element.tap()
        
        //click in search bar
        let searchbar = app.otherElements.matching(.other, identifier: "sb").searchFields.element
        searchbar.tap()
        
        //type text
        searchbar.typeText("Atessa")
        
        //since end text and cancel button are built into the searchBar UI, not testing this since the elements are difficult to find
        
        
    }

}
