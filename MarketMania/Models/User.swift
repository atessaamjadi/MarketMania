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
     */
    func buyStock(symbol: String, numShares: Double) {
        getStocks(symbols: [symbol], completion: { stockList in // only one item in stocklist
            let stock = stockList[0]
            let buyPrice: Double = stock.latestPrice ?? 0.0
            
            guard buyPrice != 0.0 else {return}
            
            // TODO, check if user has enough balance
            
            // after stock data is fetched, get price and update DB
            // example db structure: Portfolio -> AAPL -> 235434567 -> values
            self.ref.child("Portfolio").child(symbol as String).child(String(Date().timeIntervalSinceReferenceDate)).setValue([
                "buyPrice": buyPrice,
                "shares": numShares
            ], withCompletionBlock: { (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Buy data could not be saved: \(error)")
                } else {
                    // create a 'receipt' if stock purchase is successful
                    self.ref.child("History").child(String(Date().timeIntervalSinceReferenceDate)).setValue([
                        "symbol": symbol,
                        "buyPrice": buyPrice,
                        "shares": numShares,
                        "action": "BUY"
                    ])
                    
                    // update user values
                    self.updateCashBalance(delta: -1 * numShares * buyPrice)
                }
            })
        })
    }
    
    func updateCashBalance(delta: Double) -> Void {
        // get current cash balance
        self.ref.child("cashbalance").getData(completion: { (error, snapshot) in
            var balance: Double = snapshot.value as? Double ?? -1.0
            guard balance != 1.0 else {return}
            
            balance += delta
            
            // update DB value
            self.ref.child("cashbalance").setValue(balance)
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


