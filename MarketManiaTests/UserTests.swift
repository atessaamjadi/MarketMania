//
//  UserTests.swift
//  MarketManiaTests
//
//  Created by Connor Hanson on 3/27/21.
//

@testable import MarketMania
import XCTest
import Firebase

class UserTests: XCTestCase {
    
    var uid: String = ""
    var user: MarketMania.User?
    var ref: DatabaseReference!

    override func setUpWithError() throws {
        let exp = expectation(description: "login")
        self.ref = Database.database().reference()
        
        Auth.auth().signIn(withEmail: "usertests@test.com", password: "test1234") { authResult, error in
            if let error = error {
                assertionFailure("Failure to login: \(error)")
            }
            
            if (Auth.auth().currentUser?.uid != nil) {
                self.uid = Auth.auth().currentUser?.uid ?? "error"
                print("UUID: ", self.uid)
                self.ref.child(self.uid).child("cashbalance").setValue(0, withCompletionBlock: { (error, dbref) in
                    exp.fulfill()
                })
                
                
            } else {
                assertionFailure("Failure to login")
            }
        }
        
        waitForExpectations(timeout: 5)
        self.user = User(uid: self.uid, dictionary: ["": ""]) // user with empty dict
        
    }

    override func tearDownWithError() throws {
        // clear the user info each time
        
        //self.ref.child("Users").child(uid).setValue("")
        
        do {
            try Auth.auth().signOut()
        } catch {
            assertionFailure("Error signing out: " + error.localizedDescription)
        }
    }

    func testUserBuyStock() throws {
        let exp = expectation(description: "buy stock")
        user?.buyStock(symbol: "AAPL", numShares: 2, completion: { error, moneySpent in
            if let error = error {
                assertionFailure("Failed to buy singular stock: \(error)")
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 10)
        
        // check that buy is correctly recorded in DB
        
        print("yuh")
    }
    
    func testUserSellStock() throws {
        print("yuh")
    }
    
    func testUserGetStocks() throws {
        print("yuh")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
