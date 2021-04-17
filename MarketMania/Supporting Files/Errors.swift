//
//  Errors.swift
//  MarketMania
//
//  Created by Connor Hanson on 3/31/21.
//

import Foundation


enum PurchaseError: Error {
    // Throw when an invalid password is entered
    case insufficientFunds

    // Throw when an expected resource is not found
    case notFound

    // Throw in all other cases
    case unexpected(code: Int)
}

enum TransactionError: Error {
    case insufficientShares
    case noPortfolio
    case unexpected
}

enum DBError: Error {
    case noUID
    case noChild
    case notFound
    case unexpected
}

enum IEXError: Error {
    case StockNotFound
}
