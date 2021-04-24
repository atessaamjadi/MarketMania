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

// right now - just gets 10 and strings
func getTopUsers(completion: @escaping (Error?, [String]) -> Void) -> Void {
    
    ref.child("Users").getData(completion:  { error, snapshot in
        
        
        if let error = error {
            print("Error fetching list of users: \(error)")
            return
        }
        
        if snapshot.exists() {
            let allUsers: NSDictionary = snapshot.value! as! NSDictionary
            var topUsers: [String] = []
            
            for key in allUsers.allKeys {
                if topUsers.count >= 10 {
                    completion(nil, topUsers)
                    return
                }
                
                let userDict: NSDictionary = allUsers[key] as! NSDictionary
                
                if userDict.object(forKey: "username") != nil {
                    topUsers.append(userDict["username"] as! String)
                }
                            
            }
            
            completion(nil, topUsers)
        } else {
            // error
        }
        
    })
    
    
}


