//
//  GlobalFunctions.swift
//  MarketMania
//
//  Created by alex on 3/24/21.
//

import Foundation
import Firebase

//Updates the global user anywhere in the project
func fetchUser(completion: @escaping () -> ()) {
    guard let currentUserUID = Auth.auth().currentUser?.uid else {return}
    
    // Retrieves user info from Firebase

    Database.database().reference().child("Users").child(currentUserUID).observe(.value) { (snapshot) in
        
        // Creates dictionary of user information, instatiates new User object
        guard let userDict = snapshot.value as? [String: Any] else {return}
        globalCurrentUser = User(uid: currentUserUID, dictionary: userDict)
        completion()
    }
}
