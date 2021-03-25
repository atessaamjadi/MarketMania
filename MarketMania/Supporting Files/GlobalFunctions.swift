//
//  GlobalFunctions.swift
//  MarketMania
//
//  Created by alex on 3/24/21.
//

import Foundation
import Firebase

//Updates the global user anywhere in the project
func fetchUser() {
    let currentUser = Auth.auth().currentUser
    
    // Retrieves user info from Firebase

    Database.database().reference().child("Users").child((currentUser?.uid)!).observe(.value) { (snapshot) in
        
        // Creates dictionary of user information, instatiates new User object
        guard let userDict = snapshot.value as? [String: Any] else {return}
        globalCurrentUser = User(uid: (currentUser?.uid)!, dictionary: userDict)
        
    }
}
