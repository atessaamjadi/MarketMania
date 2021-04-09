//
//  WatchlistTests.swift
//  MarketManiaTests
//
//  Created by Connor Hanson on 4/8/21.
//

@testable import MarketMania
import Firebase
import XCTest

class WatchlistTests: XCTestCase {

    var uid: String = ""
    var user: MarketMania.User?
    var ref: DatabaseReference!
    var exps: [XCTestExpectation] = []
    
    override func setUpWithError() throws {

        let exp = expectation(description: "login")
        self.ref = Database.database().reference()
        
        Auth.auth().signIn(withEmail: "watchlist@test.com", password: "test123") { authResult, error in
            if let error = error {
                assertionFailure("Failure to login: \(error)")
            }
            
            if (Auth.auth().currentUser?.uid != nil) {
                self.uid = Auth.auth().currentUser?.uid ?? "error"
                print("UUID: ", self.uid)
                self.ref = Database.database().reference().child("Users").child(self.uid)
                
                // empty user then reset cash balance
                self.ref.setValue("", withCompletionBlock: { _,_ in
                    self.ref.child("cashBalance").setValue(50000.0, withCompletionBlock: { (error, dbref) in
                        if let error = error {
                            assertionFailure("Error setting up test user: \(error)")
                        }
                        
                        // now fetch user
                        exp.fulfill()
                    })
                    
                    // set something
                })
                
            } else {
                assertionFailure("Failure to login")
            }
        }
        
        waitForExpectations(timeout: 5)
        
        let fetchExp = XCTestExpectation(description: "fetch")
        
        // do something with user
        fetchUser {
           // print("GCD:", globalCurrentUser)
            fetchExp.fulfill()
            self.exps.append(XCTestExpectation(description: "updateGCU"))
        }
        
        wait(for: [fetchExp], timeout: 5)
        
        //print("GCD:", globalCurrentUser)
        
        self.user = User(uid: self.uid, dictionary: ["": ""]) // user with empty dict
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddToWatchList() throws {
        
        let exp = expectation(description: "watch")
        
        user?.addToWatchList(symbol: "AAPL", completion: { error in
            if let error = error {
                XCTFail("Error adding to watchlist: \(error)")
            }
            
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 5)
        
        user?.getWatchList(observer: { observedList in
            if !observedList.contains("AAPL") {
                XCTFail("Watchlist does not contain AAPL")
            }
        })
        
        
        let exp2 = expectation(description: "watch2")
        user?.addToWatchList(symbol: "GME", completion: { error in
            if let error = error {
                XCTFail("Error adding to watchlist: \(error)")
            }
            
            exp2.fulfill()
        })
        waitForExpectations(timeout: 5)
        
        let obsExp1 = expectation(description: "observedExp1")
        user?.getWatchList(observer: { observedList in
            if !observedList.contains("AAPL") || !observedList.contains("GME") {
                XCTFail("Watchlist should contain two items but contains: \(observedList)")
            }
            obsExp1.fulfill()
            
        })
        waitForExpectations(timeout: 5)
    }
    
    func testRemoveFromWatchlist() throws {
        let addexp = expectation(description: "add")
        let addexp1 = expectation(description: "add1")
        let addexp2 = expectation(description: "add2")
        
        
        user?.addToWatchList(symbol: "AAPL", completion: { _ in
            addexp.fulfill()
        })
        
        user?.addToWatchList(symbol: "MO", completion: { _ in
            addexp1.fulfill()
        })
        
        user?.addToWatchList(symbol: "SPOT", completion: { _ in
            addexp2.fulfill()
        })
        
        waitForExpectations(timeout: 5)
        
        let exp = expectation(description: "exp")
        let remexp = expectation(description: "rem")
        
        user?.removeFromWatchlist(symbol: "SPOT", completion: { error in
            if let error = error {
                XCTFail("Error removing SPOT: \(error)")
            }
            
            remexp.fulfill()
        })
        
        user?.getWatchList(observer: { watchList in
            XCTAssertFalse(watchList.contains("SPOT"))
            XCTAssert(watchList.contains("AAPL"))
            XCTAssert(watchList.contains("MO"))
            exp.fulfill()
        })

        waitForExpectations(timeout: 5)
    }
    
    func testEmptyRemoval() throws {
        XCTFail()
    }
    
    func testInvalidAdd() throws {
        XCTFail()
    }
}
