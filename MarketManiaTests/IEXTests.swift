//
//  IEXTests.swift
//  IEX Test Suite
//
//  Created by Connor Hanson on 03/27/21.
//

import XCTest
@testable import MarketMania

class IEXTests: XCTestCase {
    
    var stocks: [Stock] = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.stocks = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.stocks = []
    }
    
    //
    // MARK: IEX TESTING
    //
    
    func testIEXGetOneStock() throws {
        let expectation = self.expectation(description: "completionHandler")
        
        getStocks(symbols: ["AAPL"], completion: { resp in
            self.stocks = resp
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: {
            error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        })
        
        XCTAssertNotEqual(self.stocks.count, 0)
    }
    
    func testIEXGetSeveralStocks() throws {
        let expectation = self.expectation(description: "completionHandler")
        
        getStocks(symbols: ["AAPL", "FB"], completion: { resp in
            self.stocks = resp
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: {
            error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        })
        
        XCTAssertNotEqual(self.stocks.count, 0)
        // TODO, check specifics
    }
    
    func testIEXGetWinners() throws {
        
        // similar to a semaphore
        let expectation = self.expectation(description: "completionHandler")
        
        getWinners(completion: { response in
            self.stocks = response
            expectation.fulfill()
        })
        
        // timeout after 5s
        waitForExpectations(timeout: 5, handler: {
            error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        })
        
        XCTAssertNotEqual(self.stocks.count, 0, "Winners stock array is empty")
    }
    
    func testIEXGetLosers() throws {
        let expectation = self.expectation(description: "completionHandler")
        
        getLosers(completion: { response in
            self.stocks = response
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: {
            error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        })
        
        XCTAssertNotEqual(self.stocks.count, 0, "Losers stock array is empty")
    }
    
    func testIEXGetMostActive() throws {
        let expectation = self.expectation(description: "completionHandler")
        
        getMostActive(completion: { response in
            self.stocks = response
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: {
            error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        })
        
        XCTAssertNotEqual(self.stocks.count, 0, "MostActive stock array is empty")
    }
    
    func testIEXGetSector() throws {
        let expectation = self.expectation(description: "completionHandler")
        
        getCollection(type: "sector", collectionName: "Information", completion: { response in
            self.stocks = response
            print("HEREE")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: {
            error in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        })
        
        XCTAssertNotEqual(self.stocks.count, 0, "(Information) Sector stock array is empty")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
