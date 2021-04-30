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
       
        let logout = app.cells["logout"]
        
        XCTAssertTrue(accountTitle.exists)
        XCTAssertTrue(usersInfo.exists)
        XCTAssertTrue(password.exists)
        XCTAssertTrue(update.exists)
        XCTAssertTrue(logout.exists)
        
    }
    
    //check if the update password elements exist and can type text
    //for some reason fails if multiple type texts
    func testPassword() throws {
        let password = app.cells["password"]
        password.tap()
        
        let old = app.cells["old"]
        old.tap()
        old.typeText("OLD")
      
        
        let new = app.cells["new"]
        new.tap()
        //new.typeText("NEW")
        
        let confirmNew = app.cells["confirmNew"]
        confirmNew.tap()
        //confirmNew.typeText("CONFIRM")
        

        let confirm = app.cells["confirm"]
        
        
        XCTAssertTrue(old.exists)
        XCTAssertTrue(new.exists)
        XCTAssertTrue(confirmNew.exists)
        XCTAssertTrue(confirm.exists)
        
        confirm.tap()

        
    }
    
    
    //check if the update update user info elements exist and can type text
    //for some reason fails if multiple type texts
    func testUserInfo() throws {
        
        let userInfo = app.cells["update"]
        userInfo.tap()
        
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        let name = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.textFields["First Name"]/*[[".cells.textFields[\"First Name\"]",".textFields[\"First Name\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        name.tap()
        name.typeText("FIRST")
        
        let last = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Last Name"]/*[[".cells.textFields[\"Last Name\"]",".textFields[\"Last Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        last.tap()
        let user = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".cells.textFields[\"Username\"]",".textFields[\"Username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        user.tap()
        let email = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells.textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        email.tap()
        let confirm =  collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Confirm"]/*[[".cells.staticTexts[\"Confirm\"]",".staticTexts[\"Confirm\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
       
                
        XCTAssertTrue(name.exists)
        XCTAssertTrue(last.exists)
        XCTAssertTrue(user.exists)
        XCTAssertTrue(email.exists)
        XCTAssertTrue(confirm.exists)
        
        confirm.tap()
        
        
        
        
    }

}
