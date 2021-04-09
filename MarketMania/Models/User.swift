//
//  User.swift
//  BadgerBytes
//
//  Created by Thor Larson on 2/22/21.
//

import UIKit
import Firebase

struct User {
    
    //let friends: [User]
    //let stats: UserStats // why use balance instead of storing data in user?
    //let lounges: [Lounge]
    
    // info
    let email: String
    let firstName: String
    let lastName: String
    let username: String
    
    // stats
    let portfolioValue: Float
    var cashBalance: Float
    let percentGain: Float
    var portfolioStocks: [PortfolioStock]
    
    let watchList: [String] // get stock values by string
    
    // db stuff
    let uid: String
    let ref: DatabaseReference
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid // current user id
        self.email = dictionary["email"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        self.portfolioValue = dictionary["portfolioValue"] as? Float ?? -1.0
        self.cashBalance = dictionary["cashBalance"] as? Float ?? -1.0
        self.percentGain = dictionary["percentGain"] as? Float ?? -1.0
        self.watchList = dictionary["watchList"] as? [String] ?? []
        self.portfolioStocks = []
        
        //self.watchList = dictionary["stocks"] as? [Stock] ?? []
        //self.friends = dictionary["friends"] as? [User] ?? []
        //self.stats = dictionary["stats"] as? UserStats ?? UserStats(startAmmount: 50000)//starting dollar ammount
        //self.lounges = dictionary["lounges"] as? [Lounge] ?? []
        
        self.ref = Database.database().reference().child("Users").child(uid)
    }
    
    // basic user info getters and setters in this class
    
    func changePassword(pass: String) -> Bool {
        return false
    }
    
    func addFriend(user: User) -> Bool  {
        return false
    }
}


