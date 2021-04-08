//
//  LeaderboardTests.swift
//  MarketManiaTests
//
//  Created by Connor Hanson on 4/7/21.
//

@testable import MarketMania
import XCTest
import Firebase


class LeaderboardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetUserCount() throws {
        let exp = expectation(description: "wait")
        
        getUserCount(completion: { ihatelife in
            
            DispatchQueue.main.async {
                // set ui code
            }
            
            print("USERS:", ihatelife)
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 5)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
