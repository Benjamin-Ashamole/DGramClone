//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Benjamin Ashamole on 9/8/19.
//  Copyright © 2019 Benjamin Ashamole. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum MGType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    static func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    // Now whenever we want to access a storyboard we can use the following: let loginStoryboard = UIStoryboard(type: .login)
}
