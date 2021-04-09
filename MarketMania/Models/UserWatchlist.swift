//
//  UserWatchlist.swift
//  MarketMania
//
//  Created by Connor Hanson on 4/4/21.
//

import Foundation
import Firebase


extension User {
    //
    // MARK: WatchList
    //
    
    func addToWatchList(symbol: String, completion: @escaping (Error?) -> Void) -> Void {
        // check that it is a valid stock
        getStocks(symbols: [symbol], completion: { stocks in
            guard stocks.count != 0 else {
                completion(IEXError.StockNotFound)
                return
            }
            
            let stock = stocks[0]
            
            guard stock.symbol == symbol else {
                completion(IEXError.StockNotFound)
                return
            }
            
            // no need to check if it already is in watchlist, can't have duplicate keys in dictionary
            ref.child("Watchlist").child(symbol).setValue(symbol, withCompletionBlock: { error, dataref in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            })
        })
    }
    
    func removeFromWatchlist(symbol: String, completion: @escaping (Error?) -> Void) -> Void {
        ref.child("Watchlist").child(symbol).removeValue(completionBlock: { error, dataref in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        })
    }
    
    func getWatchList(observer: @escaping ([String]) -> Void) -> Void {
        ref.child("Watchlist").observe(DataEventType.value, with: { snapshot in
            
            if snapshot.exists() {
                let postDict = snapshot.value as? NSDictionary
                guard postDict != nil else { // valid case - watchlist is empty
                    observer([])
                    return
                }
                
                // TODO add better error handling. Shoudl be fine for now
                observer(postDict?.allKeys as? [String] ?? [])
            } else {
                print("Error observing data")
            }
        })
        // todo
    }
    
}
