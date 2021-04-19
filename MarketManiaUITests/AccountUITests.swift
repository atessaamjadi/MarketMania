//
//  AccountUITests.swift
//  MarketManiaUITests
//
//  Created by Connor Hanson on 4/7/21.
//

import XCTest

class AccountUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        //navigate to Account page
        let account = app.tabBars.buttons["Account"]
        account.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //test account UI elements exist
    func testElementsExist() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let accountTitle = app.navigationBars["Account"]
        let usersInfo = app.cells["userInfo"]
        
        let password = app.cells["password"]
        let update = app.cells["update"]
        let acheievements = app.cells["acheievements"]
        let logout = app.cells["logout"]
        
        XCTAssertTrue(accountTitle.exists)
        XCTAssertTrue(usersInfo.exists)
        XCTAssertTrue(password.exists)
        XCTAssertTrue(update.exists)
        XCTAssertTrue(logout.exists)
        
    }
    
    func testPassword() throws {
        
        
        
    }

}
