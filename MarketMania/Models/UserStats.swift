//
//  UserStats.swift
//  MarketMania
//
//  Created by alex on 3/23/21.
//

import Firebase
import Foundation

extension User {
    
    // set/update user portfolio info here
    
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
    func buyStock(symbol: String, numShares: Float, completion: @escaping (Error?, Float) -> Void) -> Void {
        getStocks(symbols: [symbol], completion: { stockList in // only one item in stocklist (for now)
            let stock = stockList[0]
            let buyPrice: Float = stock.latestPrice ?? 0.0
            
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
                // Users -> uid -> Portfolio -> [AAPL] -> [avgPrice, shares]
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
                        
                        let dataAvgPrice: Float = portfolioItem?["avgPrice"] as! Float
                        let dataShares: Float = portfolioItem?["shares"] as! Float
                        
                        let totVal: Float = (dataAvgPrice * dataShares) + buyPrice
                        let totShares: Float = (dataShares + numShares)
                        
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
    
    func sellStock(symbol: String, numShares: Float, completion: @escaping (Error?, Float) -> Void) -> Void {
        // todo
    }
    
    func getPortfolio() {
        // todo
    }
    
    // returns updated cash balance in completion handler
    func updateCashBalance(delta: Float, completion: @escaping (Error?, Float) -> Void) -> Void {
        // get current cash balance
        self.ref.child("cashbalance").getData(completion: { (error, snapshot) in
            
            if let error = error {
                print("error updating cash balance: \(error)")
                completion(error, 0.0)
                return
            }
            
            var balance: Float = snapshot.value as? Float ?? 0.0
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
    
    //
    // MARK: WatchList
    //
    
    func addToWatchList() {
        // todo
    }
    
    func removeFromWatchList() {
        // todo
    }
    
    func getWatchList() {
        // todo
    }
    
    
}

//struct UserStats {
//
//    let balance: Float
//    let fundsAvailable: Float
//    let stocks: [Stock]
//    let percentGain: Float
//    //let purchaseHistory:
//    let balanceHistory: [Float]
//
//    init(startAmmount: Float) {
//        self.balance = startAmmount   //Starting balance can be changed with a static constant in User.swift
//        self.fundsAvailable = startAmmount
//        self.stocks = []
//        self.percentGain = 0.0
//        balanceHistory = []
//    }
//
//    //Update portfolio values
//    func update() {
//
//    }
//
//    //calculate new balances from stock values
//    func calculateBal() {
//
//    }
//
//    //Purchase stock and update all info related
//    func purchaseStock(stock: Stock) -> Stock {
//
//        return stock
//    }
//
//    //Sell stock and update all info related
//    func sellStock(stock: Stock) -> Stock {
//        return stock
//    }
//}
