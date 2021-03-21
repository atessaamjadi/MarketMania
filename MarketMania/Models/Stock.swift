//
//  Stock.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/20/21.
//
import Foundation

class StockBasicInfo {
    let ticker: String

    init(ticker: String) {
        self.ticker = ticker
    }

    func toString() -> String {
        return "ticker: " + self.ticker + "\n"
    }
}

class Stock: StockBasicInfo {

    let name: String
    let price: Double
    let high: Double
    let low: Double
    let high_52: Double
    let low_52: Double
    let volume: Int
    let avgVolume: Int
    let marketCap: CLong
    let peRatio: Double

    init(ticker: String, dictionary: [String: Any]) {
        self.price = dictionary["price"] as? Double ?? 0.0
        self.name = dictionary["name"] as? String ?? ""
        self.high = dictionary["high"] as? Double ?? 0.0
        self.low = dictionary["low"] as? Double ?? 0.0
        self.high_52 = dictionary["high_52"] as? Double ?? 0.0
        self.low_52 = dictionary["low_52"] as? Double ?? 0.0
        self.volume = dictionary["volume"] as? Int ?? 0
        self.avgVolume = dictionary["avgVolume"] as? Int ?? 0
        self.marketCap = dictionary["marketCap"] as? CLong ?? 0
        self.peRatio = dictionary["peRatio"] as? Double ?? 0.0
        super.init(ticker: ticker)
    }

    init?(json: [String: Any]) {
        let ticker: String = json["symbol"] as? String ?? ""
        
        self.price = json["latestPrice"] as? Double ?? 0.0
        self.name = json["companyName"] as? String ?? ""
        self.high = json["high"] as? Double ?? 0.0
        self.low = json["low"] as? Double ?? 0.0
        self.high_52 = json["week52High"] as? Double ?? 0.0
        self.low_52 = json["week52Low"] as? Double ?? 0.0
        self.volume = json["volume"] as? Int ?? 0
        self.avgVolume = json["avgTotalVolume"] as? Int ?? 0
        self.marketCap = json["marketCap"] as? CLong ?? 0
        self.peRatio = json["peRatio"] as? Double ?? 0.0

        super.init(ticker: ticker)
    }

    override func toString() -> String {
        var str: String = super.toString()
        str += "name: " + self.ticker
        str += "\nprice: " + String(price)
        str += "\nhigh: " + String(high)
        str += "\nlow: " + String(low)
        str += "\n52high: " + String(high_52)
        str += "\n52low: " + String(low_52)
        str += "\nvolume: " + String(volume)
        str += "\navgVolume: " + String(avgVolume)
        str += "\nmarketCap: " + String(marketCap)
        str += "\npeRatio: " + String(peRatio) + "\n"
        return str
    }
}

class UserStock: StockBasicInfo {
    
    var numShares: Double
    var avgPrice: Double
    var marketVal: Double // float?
    var totReturns: Double
    var totPercentDelta: Double
    
    init(ticker: String, price: Double = 0.0, dictionary: [String: Any]) {
        
        numShares = dictionary["numShares"] as? Double ?? 0.0
        avgPrice = dictionary["avgPrice"] as? Double ?? 0.0
        marketVal = dictionary["marketVal"] as? Double ?? 0.0
        totReturns = dictionary["totReturns"] as? Double ?? 0.0
        totPercentDelta = dictionary["totPercentDelta"] as? Double ?? 0.0
        
        super.init(ticker: ticker)
    }
     
    func updateShares(sharesDelta: Double) {
        // TODO: update all stock info based on new shares added/removed
    }
    
}
