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
                self.ref = Database.database().reference().child("Users").child(self.uid)
                
//                self.ref.child("Users").child(self.uid).setValue(nil)
//                exp.fulfill()
                
                // empty user then reset cash balance
                self.ref.setValue("", withCompletionBlock: { _,_ in
                    self.ref.child("cashbalance").setValue(50000.0, withCompletionBlock: { (error, dbref) in
                        if let error = error {
                            assertionFailure("Error setting up test user: \(error)")
                        }
                        print("SHIT")
                        exp.fulfill()
                    })
                    
                    // set something 
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
        
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            assertionFailure("Error signing out: " + error.localizedDescription)
//        }
    }

    func testUserBuyStock() throws {
        let exp = expectation(description: "buy stock")
        user?.buyStock(symbol: "AAPL", numShares: 2, completion: { error, moneySpent in
            if let error = error {
                assertionFailure("Failed to buy singular stock: \(error)")
            }
            
            XCTAssertNotEqual(moneySpent, 0.0)
            exp.fulfill()
        })
        waitForExpectations(timeout: 5)
        
        // check that user data is correctly stored in database
        let dbexp = expectation(description: "check stock in db")
        
//        self.ref.getData { (error, snapshot) in
//            if let error = error {
//                assertionFailure("Error getting portfolio data: \(error)")
//            } else if snapshot.exists() {
//                // check that they have 2 shares of apple
//                let dict = snapshot.value as? NSDictionary
//                dump(dict, name: "Snapshot", indent: 5, maxDepth: 100, maxItems: 100)
//
//                guard ((dict?["avgPrice"] as? Double ?? -1.0) != -1.0) else {
//                    assertionFailure("No average price")
//                    return
//                }
//
//                XCTAssertEqual(dict?["shares"] as! Double, 2.0)
//                dbexp.fulfill()
//            } else {
//                assertionFailure("Portfolio shares do not exist")
//            }
//        }
        
        self.ref.child("Portfolio").child("AAPL").getData { (error, snapshot) in
            if let error = error {
                assertionFailure("Error getting portfolio data: \(error)")
            } else if snapshot.exists() {
                // check that they have 2 shares of apple
                let dict = snapshot.value as? NSDictionary
                dump(dict, name: "Snapshot", indent: 5, maxDepth: 100, maxItems: 100)

                guard ((dict?["avgPrice"] as? Double ?? -1.0) != -1.0) else {
                    assertionFailure("No average price")
                    return
                }

                XCTAssertEqual(dict?["shares"] as! Double, 2.0)
                dbexp.fulfill()
            } else {
                assertionFailure("Portfolio shares do not exist")
            }
        }
        
        waitForExpectations(timeout: 5)
        // check that buy is correctly recorded in DB
        
        print("yuh")
    }
    
    func testUserUpdateCashBalance() throws {
        user?.updateCashBalance(delta: 20.0, completion: { error, updatedBalance in
            if let error = error {
                assertionFailure("Error updating user cash balance: \(error)")
            }
            
            guard updatedBalance == 49980.0 else {
                return
            }
            
        })
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
