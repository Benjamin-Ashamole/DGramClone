//
//  User.swift
//  Makestagram
//
//  Created by Benjamin Ashamole on 7/29/19.
//  Copyright © 2019 Benjamin Ashamole. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {
    let uid: String
    let username: String
    
    init(uid: String, username: String) {
        
        self.uid = uid
        self.username = username
    }
    /* Next we create a failable initalizer.
     Failable initializers allow the initialization of an object to fail. If an initializer fails, it'll return nil instead. This is useful for requiring the initialization to have key information. In our case, if a user doesn't have a UID or a username, we'll fail the initialization and return nil. */
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
    }
    
    //Creating a user singleton
    
    //1
    private static var _current: User?
    
    //2
    static var current: User {
        
        //3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        //4
        return currentUser
    }
    
    //5
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        
        if writeToUserDefaults{
            
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }

        }
        _current = user
    }
    
    /* From Lines 34-51
     1. Create a private static variable to hold our current user. This method is private so it can't be access outside of this class.
     2. Create a computed variable that only has a getter that can access the private _current variable.
     3. Check that _current that is of type User? isn't nil. If _current is nil, and current is being read, the guard statement will crash with fatalError().
     4. If _current isn't nil, it will be returned to the user.
     5. Create a custom setter method to set the current user.
     
     Now that we've created a User singleton, we need to make sure to set it. Once we receive the user from the database, we set the singleton with our custom setter method. After the singleton is set, it will remain in memory for the rest of the app's lifecycle. It will be accessible from any view controller with the following code:
     
     let user = User.current
     */
    
}
