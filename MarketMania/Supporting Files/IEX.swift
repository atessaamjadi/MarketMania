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
let isTest = false // set to true if you want to use real data, false to use sandbox data

/**
 * Pass as array of symbols. Case does not matter. AAPL == aApl == aapl
 *
 * @return: Array of stock objects stock objects with all their fields filled out
 */
func getStocks(symbols: [String], completion: ([Stock]) -> Void) -> Void {
    
    let baseURL: String = "https://sandbox.iexapis.com/stable"
    let tok: String = tpk
    
    if (!isTest) {
//        baseURL =
//        tok = tpk
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
            
            do {
                let decoder = JSONDecoder()
                let stock = try decoder.decode(Stock.self, from: data)
                ret.append(stock)
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    // pass returned stock array to callback/completion function
    completion(ret)
}

func getWinners(completion: @escaping ([Stock]) -> Void) -> Void {
    return getMovers(type: "gainers", completion: completion)
}

func getLosers(completion: @escaping ([Stock]) -> Void) -> Void {
    return getMovers(type: "losers", completion: completion)
}

func getMostActive(completion: @escaping ([Stock]) -> Void) -> Void {
    return getMovers(type: "mostactive", completion: completion)
}

private func getMovers(type: String, completion: @escaping ([Stock]) -> Void) -> Void {
    let baseURL: String = "https://sandbox.iexapis.com/stable"
    let tok: String = tpk
    var ret: [Stock] = []
    
    if (!isTest) {
//        baseURL = "https://sandbox.iexapis.com/stable"
//        tok = tpk
    } else {
        // TODO: set base url to live api, and use production key in tok
    }
    
    let session = URLSession.shared
    
    let url = URL(string: baseURL + "/stock/market/list/" + type + "?token=" + tok)!
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
            let decoder = JSONDecoder()
            ret = try decoder.decode([Stock].self, from: data)
            
            completion(ret) // this passes the value set in ret ([Stock]) to the callback arg ([Stock])
        } catch let error {
            print("Error decoding JSON: " + error.localizedDescription)
        }
    })
    task.resume()
    
}
