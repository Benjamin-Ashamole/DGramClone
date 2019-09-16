//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Benjamin Ashamole on 7/29/19.
//  Copyright © 2019 Benjamin Ashamole. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
    }
    //The commented code below is refactored with the networking layer moved to UserService.swift
//    @IBAction func nextButtonTapped(_ sender: UIButton) {
//
//        //1
//        guard let firUser = Auth.auth().currentUser,
//        let username = usernameTextField.text,
//            !username.isEmpty else { return }
//        //2
//        let userAttrs = ["username": username]
//        //3
//        let ref = Database.database().reference().child("users").child(firUser.uid)
//        //4
//        ref.setValue(userAttrs) { (error, ref) in
//            if let error = error {
//                assertionFailure( error.localizedDescription)
//                return
//            }
//            //5
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                let user = User(snapshot: snapshot)
//
//            })
//        }
//        /* 1. First we guard to check that a FIRUser is logged in and that the user has provided a username in the text field.
//        2. We create a dictionary to store the username the user has provided inside our database
//        3. We specify a relative path for the location of where we want to store our data
//        4. We write the data we want to store at the location we provided in step 3
//        5. We read the user we just wrote to the database and create a user from the snapshot
//         Now whenever an user is created, a user JSON object will also be created for them within our database.
//         */
//
//    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            print("Created new user: \(user.username)")
            
            User.setCurrent(user)
            
            //1.
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//
//            //2.
//            if let initialViewController = storyboard.instantiateInitialViewController() {
//
//                //3.
//                self.view.window?.rootViewController = initialViewController
//                self.view.window?.makeKeyAndVisible()
//            }
            //1.Create a new instance of our main storyboard
            //2. Check that the storyboard has an initial view controller
            //3. Get reference to the current window and set the rootViewController to the initial view controller
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
