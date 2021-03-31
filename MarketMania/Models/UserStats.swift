//
//  UserStats.swift
//  MarketMania
//
//  Created by alex on 3/23/21.
//

struct UserStats {
    
    let balance: Float
    let fundsAvailable: Float
    let stocks: [Stock]
    let percentGain: Float
    //let purchaseHistory:
    let balanceHistory: [Float]
    
    init(startAmmount: Float) {
        self.balance = startAmmount   //Starting balance can be changed with a static constant in User.swift
        self.fundsAvailable = startAmmount
        self.stocks = []
        self.percentGain = 0.0
        balanceHistory = []
    }
    
    //Update portfolio values
    func update() {
        
    }
    
    //calculate new balances from stock values
    func calculateBal() {
        
    }
    
    //Purchase stock and update all info related
    func purchaseStock(stock: Stock) -> Stock {
        
        return stock
    }
    
    //Sell stock and update all info related
    func sellStock(stock: Stock) -> Stock {
        return stock
    }
}
