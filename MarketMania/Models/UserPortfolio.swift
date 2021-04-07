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
        getStocks(symbols: [symbol], completion: { stockList in // only one item in stocklist
            
            guard stockList.count == 1 else {
                completion(PurchaseError.unexpected(code: 500), 0.0)
                return
            }
            
            let stock = stockList[0]
            let buyPrice: Float = stock.latestPrice ?? 0.0
            
            //print("BUYING", stockList)
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
                    } else if snapshot.exists(){
                        
                        //
                        // TODO: My averaging math is fucky here but idrk why
                        //
                        
                        // and get values and add to it
                        //print("SNAPSHOT:", snapshot.value)
                        let dict = (snapshot.value as? NSDictionary) // base dict
                        let portfolioElements = dict?["Portfolio"] as? NSDictionary // portfolio dict
                        let portfolioItem = portfolioElements?[stock.symbol!] as? NSDictionary // stock item
                        
                        guard portfolioElements != nil && portfolioItem != nil else {
                            // item not yet in portfolio
                            self.ref.child("Portfolio").child(stock.symbol!).setValue([
                                "avgPrice": buyPrice,
                                "shares": numShares
                            ])
                            completion(nil, updatedBalance)
                            return
                        }
                        
                        dump(dict, name: "1Distc", indent: 0, maxDepth: 100, maxItems: 100)
                        dump(portfolioItem, name: "NSDICT", indent: 0, maxDepth: 100, maxItems: 100)
                        dump(portfolioElements, name: "FUCK", indent: 0, maxDepth: 100, maxItems: 100)
                        
                        let dataAvgPrice: Float = portfolioItem?["avgPrice"] as! Float
                        let dataShares: Float = portfolioItem?["shares"] as! Float
                        
                        let totVal: Float = (dataAvgPrice * dataShares) + (buyPrice * numShares)
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
        
        // check if user actually has the stock && enough shares
        //getPortfolio(completion: <#T##(Error?, [PortfolioStock]) -> Void#>)
        
        getPortfolio(completion: { error, portfolioStocks in
            
        })
        
        
        // todo
    }
    
    
    /**
     Get portfolio with all the relevant values (symbol, numShares, avgPrice, ...)
     Returns values that are currently stored in firebase
     
     Returns
     */
    func getPortfolio(completion: @escaping (Error?, [PortfolioStock]) -> Void) -> Void {
        self.ref.getData(completion: { error, snapshot in
            if let error = error {
                print("Error fetching portfolio data: \(error)")
                completion(error, [])
                return
            }
            
            if snapshot.exists() {
                let userDict = snapshot.value as? NSDictionary
                let portfolioDict = userDict?["Portfolio"] as? NSDictionary
                guard portfolioDict != nil else {
                    // portfolio is empty/DNE
                    completion(nil, [])
                    return
                }
                
                var stockArray: [PortfolioStock] = []
                
                for key in portfolioDict?.allKeys ?? [] {
                    let stockDict = portfolioDict?[key] as? NSDictionary
                    var stock: PortfolioStock = PortfolioStock(symbol: key as! String, shares: stockDict?["shares"] as! Float, avgPrice: stockDict?["avgPrice"] as! Float)
                    
                    stock.symbol = key as? String
                    stock.avgPrice = stockDict?["avgPrice"] as? Float
                    stock.shares = stockDict?["shares"] as? Float
                    
                    stockArray.append(stock)
                }
                
                completion(nil, stockArray)
            } else {
                completion(nil, [])
            }
        })
    }
    
    // returns updated cash balance in completion handler
    func updateCashBalance(delta: Float, completion: @escaping (Error?, Float) -> Void) -> Void {
        // get current cash balance
        self.ref.child("cashBalance").getData(completion: { (error, snapshot) in
            
            if let error = error {
                print("error updating cash balance: \(error)")
                completion(error, 0.0)
                return
            }
            
            let userDict = snapshot.value as? NSDictionary
            
            guard var balance = userDict?["cashBalance"] as? Float else {
                dump(userDict, name: "Cash Snapshot", indent: 0, maxDepth: 5, maxItems: 5)
                completion(PurchaseError.notFound, 0.0)
                return
            }
                        
            print("BALANCE:", balance)
            guard balance != 0.0 else {
                completion(PurchaseError.insufficientFunds, 0.0)
                return
            }
            
            balance += delta
            
            // update DB value
            self.ref.child("cashBalance").setValue(balance)
            completion(nil, balance)
            print("cash updated")
        })
    }
    
    //Updates the current users portfolio balance
    func updatePortfolioValue(completion: @escaping (Error?, Float) -> Void) -> Void {
        var totalValue = cashBalance
        
        var userStockNames : [String] = []
        getPortfolio(completion: {error, myStockList in
            for stock in myStockList{
                userStockNames.append(stock.symbol!)
            }
            
            getStocks(symbols: userStockNames, completion: {curStockList in
                var i = 0
                for stock in curStockList{
                    totalValue += stock.latestPrice! * myStockList[i].avgPrice!
                    i+=1
                }
            })
            
            ref.child("portfolioValue").setValue(totalValue)
            completion(nil,totalValue)
            
        })

    }
    
}
