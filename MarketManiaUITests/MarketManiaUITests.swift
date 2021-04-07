//
//  MarketManiaUITests.swift
//  MarketManiaUITests
//
//  Created by Thor Larson on 3/16/21.
//

import XCTest
@testable import MarketMania

class MarketManiaUITests: XCTestCase {
    
    var app: XCUIApplication!
    // https://developer.apple.com/documentation/xctest/xcuiapplication -> class documentation
    // https://developer.apple.com/documentation/xctest/xcuielement -> actions which app can use
    
    // https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet -> good reference
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launchArguments.append("isUITestingLogin")
        
        // UI tests must launch the application that they test.
        app.launch()
        
        // launch is cold start, use activate when entering app from home screen, etc
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginViewExists() throws {
        
        // Use this to print the current state of the application and to get a log view of all the elements contained within the current view
        
//        print("STATE:", app.state)
//        print("DEBUG:", app.debugDescription)
        
        // check that all labels exist
        XCTAssert(app.staticTexts["titleLabel"].exists)

        // check that all inputviews/textfields exist
        XCTAssert(app.otherElements["emailInputView"].exists)
        XCTAssert(app.otherElements["passwordInputView"].exists)
        
        // check that buttons exist
        XCTAssert(app.buttons["signInButton"].exists)
        XCTAssert(app.buttons["signUpButton"].exists)
        
        // check that containers exist
        XCTAssert(app.otherElements["containerView"].exists)
        XCTAssert(app.otherElements["inputBackgroundView"].exists)
        
        // background img
        XCTAssert(app.images["backgroundImageView"].exists)

        // also check furthur within the elements that each of their elements are displayed/work correctly
        
        let emailInputView = app.otherElements["emailInputView"]
        let emailText = emailInputView.textFields.element(boundBy: 0)
        let emailUnderLine = emailInputView.otherElements.element(boundBy: 0)
        XCTAssert(emailText.exists)
        XCTAssert(emailText.placeholderValue == "Email")
        XCTAssert(emailUnderLine.exists)
        
        let passwordInputView = app.otherElements["passwordInputView"]
        let passwordText = passwordInputView.secureTextFields.element(boundBy: 0)
        let passwordUnderLine = passwordInputView.otherElements.element(boundBy: 0)
        XCTAssert(passwordText.exists)
        XCTAssert(passwordText.placeholderValue == "Password")
        XCTAssert(passwordUnderLine.exists)
    }
    
    // to pass this test you need to slightly change device settings (ios)
    // Simulator -> I/O -> Keyboard -> Connect Hardware Keyboard should be OFF
    func testValidLogin() throws {
                        
        let emailInputView = app.otherElements["emailInputView"]
        XCTAssert(emailInputView.isEnabled)
        emailInputView.tap()
        emailInputView.textFields.element.typeText("testUI@test.com")
        
        let passwordInputView = app.otherElements["passwordInputView"]
        XCTAssert(passwordInputView.isEnabled)
        passwordInputView.tap()
        passwordInputView.secureTextFields.element(boundBy: 0).typeText("test123")
        
        app.buttons["signInButton"].tap()
        
        
        print(app.debugDescription)

        // check that all labels exist
        XCTAssertFalse(app.staticTexts["titleLabel"].exists)

        // check that all inputviews/textfields exist
        XCTAssertFalse(app.otherElements["emailInputView"].exists)
        XCTAssertFalse(app.otherElements["passwordInputView"].exists)
        
        // check that buttons exist
        XCTAssertFalse(app.buttons["signInButton"].exists)
        XCTAssertFalse(app.buttons["signUpButton"].exists)
        
        // check that containers exist
        XCTAssertFalse(app.otherElements["containerView"].exists)
        XCTAssertFalse(app.otherElements["inputBackgroundView"].exists)
        
        // background img
        XCTAssertFalse(app.images["backgroundImageView"].exists)
    }
    
    func testInvalidLogin() throws {
        
        let emailInputView = app.otherElements["emailInputView"]
        XCTAssert(emailInputView.isEnabled)
        emailInputView.tap()
        emailInputView.textFields.element.typeText("testUI@test.com")
        
        let passwordInputView = app.otherElements["passwordInputView"]
        XCTAssert(passwordInputView.isEnabled)
        passwordInputView.tap()
        passwordInputView.secureTextFields.element(boundBy: 0).typeText("wrong_password")
        
        app.buttons["signInButton"].tap()
        
        print(app.debugDescription)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
