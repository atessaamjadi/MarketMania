//
//  FirebaseUtils.swift
//  BadgerBytes
//
//  Created by Thor Larson on 2/25/21.
//

import Firebase
import Foundation

let ref = Database.database().reference()

// function runs now, 'promises' completion function once the rest of the function is done running
// Int is what we are promising from this function
func getUserCount(completion: @escaping (Int) -> Void) -> Void {
    ref.child("Users").getData(completion: { error, snapshot in
        
        if let error = error {
            print("Descriptive error: \(error)")
            return
        }
        
        if snapshot.exists() {
            let userDict = snapshot.value as? NSDictionary // cast to dictionary we can use
            completion(userDict?.allKeys.count ?? -1)
        } else {
            // do error handling
        }
        
    })
}


