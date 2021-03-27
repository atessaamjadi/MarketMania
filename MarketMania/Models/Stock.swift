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

// is this used?
//struct Sector: Codable {
//    let name: String ?? ""
//}

//extension UserStock {
//
//    var numShares: Double
//    var avgPrice: Double
//    var marketVal: Double // float?
//    var totReturns: Double
//    var totPercentDelta: Double
//
//    init(ticker: String, price: Double = 0.0, dictionary: [String: Any]) {
//
//        numShares = dictionary["numShares"] as? Double ?? 0.0
//        avgPrice = dictionary["avgPrice"] as? Double ?? 0.0
//        marketVal = dictionary["marketVal"] as? Double ?? 0.0
//        totReturns = dictionary["totReturns"] as? Double ?? 0.0
//        totPercentDelta = dictionary["totPercentDelta"] as? Double ?? 0.0
//
//        super.init(ticker: ticker)
//    }
//
//    func updateShares(sharesDelta: Double) {
//        // TODO: update all stock info based on new shares added/removed
//    }
//}
