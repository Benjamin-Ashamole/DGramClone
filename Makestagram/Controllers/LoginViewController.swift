//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Benjamin Ashamole on 7/24/19.
//  Copyright © 2019 Benjamin Ashamole. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase


//Line below is to deal with namespace issues. FIRUser tells us we are referencing a user from Firebase, not the user class we created.
typealias FIRUser = FirebaseAuth.User
let user: FIRUser? = Auth.auth().currentUser

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
    }
    
    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
        
        // Dispose of any resource that can be recreated
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        //authUI?.isSignInWithEmailHidden = true

        let providers: [FUIAuthProvider] = [

            FUIEmailAuth(),
            FUIGoogleAuth()
        ]

        authUI?.providers = providers

        let authViewController = authUI?.authViewController()

        self.present(authViewController!, animated: true) { }
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FirebaseAuth.User?, authDataResult: AuthDataResult?, error: Error?) {
        
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = authDataResult?.user
            else { return }
        
//        let userRef = Database.database().reference().child("users").child(user.uid)
//
//        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
//        /*  When we retrieve data from Firebase, we receive a DataSnapshot object that contains the data we retrieved. We can now access the data through its value property:
//
//         Data will be returned as one of the following native types: NSDictionary, NSArray, NSNumber (includes booleans), NSString.
//
//         In the case of our user that we retrieved, we'll expect the data to be returned as a dictionary.
//         */
//
//            if let user = User(snapshot: snapshot) {
//
//                User.setCurrent(user)
//
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//
//                if let initialViewController = storyboard.instantiateInitialViewController() {
//                    self.view.window?.rootViewController = initialViewController
//                    self.view.window?.makeKeyAndVisible()
//                }
//            } else {
//                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
//            }
//
//    })
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
             else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
        
        
        //authDataResult?.user.uid
        //performSegue(withIdentifier: "goHome", sender: self)
    }
}
