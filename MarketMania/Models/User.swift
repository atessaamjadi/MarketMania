//
//  User.swift
//  BadgerBytes
//
//  Created by Thor Larson on 2/22/21.
//

import UIKit

struct User {
    
    let uid: String
    let email: String
    let firstName: String
    let lastName: String
    let watchList: [Stock]
    let friends: [User]
    let stats: UserStats
    let lounges: [Lounge]
    
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.watchList = dictionary["stocks"] as? [Stock] ?? []
        self.friends = dictionary["friends"] as? [User] ?? []
        self.stats = dictionary["stats"] as? UserStats ?? UserStats(startAmmount: 50000)//starting dollar ammount
        self.lounges = dictionary["lounges"] as? [Lounge] ?? []
    }
    
    func getUserStats() -> UserStats {
        return self.stats
    }
    
    func joinLounge(lounge: Lounge) -> Bool {
        return false
    }
    
    func leaveLounge(lounge: Lounge) -> Bool {
        return false
    }
    
    func addToWatchList(stock: Stock) -> Bool {
        return false
    }
    
    func changePassword(pass: String) -> Bool {
        return false
    }
    
    func addFriend(user: User) -> Bool  {
        return false
    }
}


