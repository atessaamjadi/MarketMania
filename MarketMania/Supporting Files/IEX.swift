//
//  IEX_Data.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/20/21.
//
import Foundation

// TODO: store in environment variable
// not urgent since this is the public sandbox key.
// Do not put any other key in this variable
let tpk: String = "Tpk_03bc85510ff64107800ae53bbfafa504" // test public key
static let isTest = false // set to true if you want to use real data, false to use sandbox data

/**
 * Pass as array of symbols. Case does not matter. AAPL == aApl == aapl
 *
 * @return: Array of stock objects stock objects with all their fields filled out
 */
func getStocks(symbols: [String]) -> [Stock] {
    
    var baseURL: String
    var tok: String
    
    if (!isTest) {
        baseURL = "https://sandbox.iexapis.com/stable"
        tok = tpk
    } else {
        // TODO: set base url to live api, and use production key in tok
    }
    
    let session = URLSession.shared
    var ret: [Stock] = []
    
    for symbol in symbols {
        let url = URL(string: baseURL + "/stock/" + symbol + "/quote?token=" + tok)!
        let req = URLRequest(url: url)
        
        let task = session.dataTask(with: req as URLRequest, completionHandler: {
            data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            print("DATA: ")
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                let stock: Stock = Stock(json: json ?? ["none": []])! // default to empty
                
                print(stock.toString())
                ret.append(stock)
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    return ret
}


