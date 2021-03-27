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
let pk: String = ""
let tok: String = tpk

let isTest = false // set to true if you want to use real data, false to use sandbox data

let testURL: String = "https://sandbox.iexapis.com/stable"
let productionURL: String = ""
let baseURL: String = testURL

/**
 * Pass as array of symbols. Case does not matter. AAPL == aApl == aapl
 *
 * @return: Array of stock objects stock objects with all their fields filled out
 */
func getStocks(symbols: [String], completion: ([Stock]) -> Void) -> Void {
    
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
    let urlString: String = baseURL + "/stock/market/list/gainers?token=" + tok
    return getListOfStocks(urlString: urlString, completion: completion)
}

func getLosers(completion: @escaping ([Stock]) -> Void) -> Void {
    let urlString: String = baseURL + "/stock/market/list/losers?token=" + tok
    return getListOfStocks(urlString: urlString, completion: completion)
}

func getMostActive(completion: @escaping ([Stock]) -> Void) -> Void {
    let urlString: String = baseURL + "/stock/market/list/mostactive?token=" + tok
    return getListOfStocks(urlString: urlString, completion: completion)
}

/**
 Valid Types: sector, tag, list
 */
func getCollection(type: String, collectionName: String, completion: @escaping ([Stock]) -> Void) -> Void {
    guard (type == "sector" || type == "tag" || type == "list") else {
        return
    }
    
    // TODO: Must URL Encode collectionName
    
    let urlString: String = baseURL + "/stock/market/collection/" + type + "?collectionName=" +
        collectionName + "&token=" + tok
    return getListOfStocks(urlString: urlString, completion: completion)
}

/**
 Returns a list  of less than or equal to 10 stocks through the completion handler's arg (@escaping ([Stock]))
 */
private func getListOfStocks(urlString: String, completion: @escaping ([Stock]) -> Void) -> Void {
    var ret: [Stock] = []
    
    let session = URLSession.shared
    let url = URL(string: urlString)!
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
            // TODO: find way to limit response size to allow for quicker page loading
            
            let decoder = JSONDecoder()
            ret = try decoder.decode([Stock].self, from: data)
            completion(ret) // this passes the value set in ret ([Stock]) to the callback arg ([Stock])
        } catch let error {
            print("Error decoding JSON: " + error.localizedDescription)
        }
    })
    task.resume()
}

