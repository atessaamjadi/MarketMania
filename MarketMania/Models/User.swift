//
//  User.swift
//  BadgerBytes
//
//  Created by Thor Larson on 2/22/21.
//

import UIKit
import Firebase

struct User {
    
    let uid: String
    let email: String
    let firstName: String
    let lastName: String
    let watchList: [Stock]
    let friends: [User]
    let stats: UserStats // why use balance instead of storing data in user?
    let lounges: [Lounge]
    let ref: DatabaseReference
    
    //var balance: Float
    
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid // current user id
        self.email = dictionary["email"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.watchList = dictionary["stocks"] as? [Stock] ?? []
        self.friends = dictionary["friends"] as? [User] ?? []
        self.stats = dictionary["stats"] as? UserStats ?? UserStats(startAmmount: 50000)//starting dollar ammount
        self.lounges = dictionary["lounges"] as? [Lounge] ?? []
        
        self.ref = Database.database().reference().child("Users").child(uid)
    }
    
    /**
     User buys some amount of a single stock by it's symbol name
     The application returns a single stock quote, and the latest price is checked and saved if valid
     Then save the stock purchase in the user's portfolio with values {symbol: {timeStamp:["buyPrice", "shares"]}}
     If this is successful, save a receipt by the timestamp as {timestamp: [symbol, buyPrice, shares, action (BUY/SELL)]}
     Then updates the user's cash balance
     
     @param symbol: A single stock symbol (eg: AAPL, FB). Case Insensitive
     @param numShares: any Double > 0.0
     
     @return amount of money left in balance after transaction - return 0.0 if purchase falls through
     TODO: Add error return to completion handlers
     */
    func buyStock(symbol: String, numShares: Double, completion: @escaping (Error?, Double) -> Void) -> Void {
        getStocks(symbols: [symbol], completion: { stockList in // only one item in stocklist (for now)
            let stock = stockList[0]
            let buyPrice: Double = stock.latestPrice ?? 0.0
            
            print("BUYING", stockList)
            guard buyPrice != 0.0 else {
                completion(PurchaseError.insufficientFunds, 0.0) // TODO: update to more appropriate error
                return
            }
            guard uid != "" else {
                completion(DBError.noUID, 0.0)
                return
            }
                        
            self.updateCashBalance(delta: -1 * numShares * buyPrice, completion: {
                error, updatedBalance in
                
                // check if sufficient balance
                guard updatedBalance > 0 else {
                    print("Unable to purchase shares, not enough money in account")
                    completion(PurchaseError.insufficientFunds, updatedBalance)
                    return
                }
                
                // now check if stock exists in portfolio
                self.ref.child("Portfolio").child(stock.symbol!).getData { (error, snapshot) in
                    if let error = error {
                        print("Error fetching portfolio data: \(error)")
                        completion(error, 0.0)
                        return
                    } else if snapshot.exists() {
                        
                        //
                        // TODO: My averaging math is fucky here but idrk why
                        //
                        
                        // and get values and add to it
                        let dict = (snapshot.value as? NSDictionary)
                        let portfolioElements = dict?["Portfolio"] as? NSDictionary
                        let portfolioItem = portfolioElements?[stock.symbol] as? NSDictionary
                        dump(dict, name: "1Distc", indent: 0, maxDepth: 100, maxItems: 100)
                        dump(portfolioItem, name: "NSDICT", indent: 0, maxDepth: 100, maxItems: 100)
                        dump(portfolioElements, name: "FUCK", indent: 0, maxDepth: 100, maxItems: 100)
                        guard portfolioItem != nil else {
                            completion(PurchaseError.unexpected(code: 500), 0.0)
                            return
                        }
                        
                        let dataAvgPrice: Double = portfolioItem?["avgPrice"] as! Double
                        let dataShares: Double = portfolioItem?["shares"] as! Double
                        
                        let totVal: Double = (dataAvgPrice * dataShares) + buyPrice
                        let totShares: Double = (dataShares + numShares)
                        
                        self.ref.child("Portfolio").child(stock.symbol!).setValue([
                            "avgPrice": totVal / totShares,
                            "shares": totShares
                        ])
                        
                        completion(nil, updatedBalance)
                    } else {
                        // item not yet in portfolio
                        self.ref.child("Portfolio").child(stock.symbol!).setValue([
                            "avgPrice": buyPrice,
                            "shares": numShares
                        ])
                        completion(nil, updatedBalance)
                    }
                }
            })
        })
    }
    
    // returns updated cash balance in completion handler
    func updateCashBalance(delta: Double, completion: @escaping (Error?, Double) -> Void) -> Void {
        // get current cash balance
        self.ref.child("cashbalance").getData(completion: { (error, snapshot) in
            
            if let error = error {
                print("error updating cash balance: \(error)")
                completion(error, 0.0)
                return
            }
            
            var balance: Double = snapshot.value as? Double ?? 0.0
            guard balance != 0.0 else {
                completion(PurchaseError.insufficientFunds, 0.0)
                return
            }
            
            balance += delta
            
            // update DB value
            self.ref.child("cashbalance").setValue(balance)
            completion(nil, balance)
            print("cash updated")
        })
    }
    
    func getUserStats() -> UserStats {
        return self.stats
    }
    
    func joinLounge(lounge: Lounge) -> Bool {
        return false
    }
    
    func leaveLounge(lounge: Lounge) -> Bool {
        return false
    }
    
    func addToWatchList(stock: Stock) -> Bool {
        return false
    }
    
    func changePassword(pass: String) -> Bool {
        return false
    }
    
    func addFriend(user: User) -> Bool  {
        return false
    }
}


