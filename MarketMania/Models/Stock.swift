//
//  Stock.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/20/21.
//
import Foundation

struct Stock: Codable {
    let symbol: String? // also used in portfolio
    let companyName: String?
    let latestPrice: Float?
    let high: Float?
    let low: Float?
    let open: Float?
    let close: Float?
    let week52High: Float?
    let week52Low: Float?
    let volume: Int?
    let avgTotalVolume: Int?
    let marketCap: CLong?
    let peRatio: Float?
    let changePercent: Float?
}

// credit: https://swiftsenpai.com/swift/decode-dynamic-keys-json/
struct StockBatch: Decodable {
    
    // Define DynamicCodingKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DynamicCodingKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    let array: [[String: Stock]]
    //let quotes: [[String: Stock]]
    //let stocks: [Stock]
    
    init(from decoder: Decoder) throws {
        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [[String: Stock]]()

        // 2
        // Loop through each key (Stock) in container
        for key in container.allKeys {
            print("KEY", key)

            // Decode Student using key & keep decoded Student object in tempArray
            let decodedObject = try container.decode([String: Stock].self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        
        // 3
        // Finish decoding all Stock objects. Thus assign tempArray to array.
        array = tempArray
    }
}

struct PortfolioStock {
    var symbol: String?
    var shares: Float?
    var avgPrice: Float?
    
    init(symbol: String, shares: Float, avgPrice: Float) {
        self.symbol = symbol
        self.shares = shares
        self.avgPrice = avgPrice
    }
}
