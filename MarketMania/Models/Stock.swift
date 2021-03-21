//
//  Stock.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/20/21.
//
import Foundation

class StockBasicInfo {
    let name: String
    let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    func toString() -> String {
        var str: String = "name: " + self.name
        str += "\nprice: " + String(self.price) + "\n"
        return str
    }
}

class StockDetailInfo: StockBasicInfo {

    let ticker: String
    let high: Double
    let low: Double
    let high_52: Double
    let low_52: Double
    let volume: Int
    let avgVolume: Int
    let marketCap: CLong
    let peRatio: Double

    init(name: String, price: Double, dictionary: [String: Any]) {
        self.ticker = dictionary["ticker"] as? String ?? ""
        self.high = dictionary["high"] as? Double ?? 0.0
        self.low = dictionary["low"] as? Double ?? 0.0
        self.high_52 = dictionary["high_52"] as? Double ?? 0.0
        self.low_52 = dictionary["low_52"] as? Double ?? 0.0
        self.volume = dictionary["volume"] as? Int ?? 0
        self.avgVolume = dictionary["avgVolume"] as? Int ?? 0
        self.marketCap = dictionary["marketCap"] as? CLong ?? 0
        self.peRatio = dictionary["peRatio"] as? Double ?? 0.0
        super.init(name: name, price: price)
    }

    init?(json: [String: Any]) {
        let name: String = json["companyName"] as? String ?? ""
        let price: Double = json["latestPrice"] as? Double ?? 0.0

        self.ticker = json["symbol"] as? String ?? ""
        self.high = json["high"] as? Double ?? 0.0
        self.low = json["low"] as? Double ?? 0.0
        self.high_52 = json["week52High"] as? Double ?? 0.0
        self.low_52 = json["week52Low"] as? Double ?? 0.0
        self.volume = json["volume"] as? Int ?? 0
        self.avgVolume = json["avgTotalVolume"] as? Int ?? 0
        self.marketCap = json["marketCap"] as? CLong ?? 0
        self.peRatio = json["peRatio"] as? Double ?? 0.0

        super.init(name: name, price: price)
    }

    override func toString() -> String {
        var str: String = super.toString()
        str += "ticker: " + self.ticker
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
