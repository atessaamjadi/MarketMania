//
//  IEX_Data.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/20/21.
//
import Foundation

func TOPS(symbols: [String]) {


    let url = URL(string: "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=Tpk_03bc85510ff64107800ae53bbfafa504")!
    let session = URLSession.shared
    let req = URLRequest(url: url)

    let task = session.dataTask(with: req as URLRequest, completionHandler: {
        data, response, error in

        guard error == nil else {
            return
        }

        guard let data = data else {
            return
        }

        print("DATA: ")
        print(data)

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            let stock: StockDetailInfo = StockDetailInfo(json: json ?? [":": []])!
            print(stock.toString())

        } catch let error {
            print(error.localizedDescription)
        }
    })

    task.resume()

}

