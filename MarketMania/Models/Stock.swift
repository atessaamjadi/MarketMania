//
//  Stock.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/20/21.
//
import Foundation



struct Stock: Codable {
    let symbol: String?
    let companyName: String?
    let latestPrice: Double?
    let high: Double?
    let low: Double?
    let open: Double?
    let close: Double?
    let week52High: Double?
    let week52Low: Double?
    let volume: Int?
    let avgTotalVolume: Int?
    let marketCap: CLong?
    let peRatio: Double?
    let changePercent: Double?
}

//struct PurchasedStock {
//    private let symbol: String
//    private let purchasePrice: Double
//    private let purchaseTime: Date
//    private let dateString: String
//    private var numShares: Double
//    
//    init(symbol: String, price: Double, numShares: Double) {
//        self.symbol = symbol
//        self.purchasePrice = price
//        self.numShares = numShares
//
//        // setup date components
//        let dateFormatter: DateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
//        self.purchaseTime = Date()
//        self.dateString = dateFormatter.string(from: self.purchaseTime)
//    }
//    
//    func getSymbol() -> String {return self.symbol}
//    func getPurchasePrice() -> Double {return self.purchasePrice}
//    func getPurchaseTimeString() -> String {return self.dateString}
//    func getPurchaseTime() -> Date {return self.purchaseTime}
//    func getNumShares() -> Double {return self.numShares}
//    
//    mutating func removeShares(numSold: Double) -> Double {
//        // sold all in this order
//        guard numSold < numShares else {
//            let numChanged = numShares
//            numShares = 0
//            return numChanged
//        }
//        
//        // some are left over
//        numShares -= numSold
//        return numSold
//    }
//}
//
//// collection of purchased stocks by symbol name
//class StockCollection {
//    private let symbol: String
//    private var stocks: [PurchasedStock]
//    private var numShares: Double
//    private var marketValue: Double
//    
//    init(symbol: String) {
//        self.symbol = symbol
//        self.stocks = []
//        self.numShares = 0.0
//        self.marketValue = 0.0
//    }
//    
//    // init with a list of stocks to be added to collection
//    init(symbol: String, stocks: [PurchasedStock]) {
//        self.symbol = symbol
//        self.stocks = stocks
//        self.numShares = 0.0
//        self.marketValue = 0.0
//        
//        for stock in stocks {
//            self.numShares += stock.getNumShares()
//            self.marketValue += stock.getPurchasePrice() * stock.getNumShares()
//        }
//    }
//    
//    func getAveragePrice() -> Double {
//        return self.marketValue / self.numShares
//    }
//    
//    func getCollection() -> [PurchasedStock] {return self.stocks}
//    func getName() -> String {return self.symbol}
//    func isEmpty() -> Bool {return stocks.isEmpty}
//    
//    // remove in FIFO
//    // fixme
//    func removeFromCollection(numToRemove: Double) -> Double? {
//        
////        var removedStocks: [PurchasedStock] = []
////
////        guard numRemoved > 0 else {return []}
////        guard (numRemoved <= stocks.count) else {
////            removedStocks = self.stocks
////            self.stocks = []
////            return removedStocks
////        } // remove all
////
////        // pop last n stocks off end of collection
////        for _ in 1...numRemoved {
////            removedStocks.append(self.stocks.popLast()!)
////        }
////
////        return removedStocks
//        
//        var removedStocks: [PurchasedStock] = []
//        var numRemoved: Double = 0.0
//        var salePrice: Double = 0.0
//        var leftToSell: Double = numToRemove
//        
//        guard numToRemove > 0 else {return nil}
//        guard numToRemove < self.numShares else {return nil}
//        
//        while (leftToSell > 0) {
//            var stock: PurchasedStock = self.stocks.last!
//            let numSold: Double = stock.removeShares(numSold: leftToSell)
//            
//            leftToSell -= numSold
//            salePrice += (stock.getPurchasePrice() * numSold)
//        }
//        
//    }
//    
//    func addToCollection(numAdded: Double, price: Double) -> Bool {
//        guard numAdded > 0 else {return false}
//        
//        let newStock = PurchasedStock(symbol: self.symbol, price: price, numShares: numAdded)
//        self.stocks.insert(newStock, at: 0)
//        self.marketValue += (numAdded * price)
//        self.numShares += numAdded
//        return true
//    }
//    
//}
