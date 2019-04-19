//
//  Config.swift
//  AnAppHasNoName
//
//  Created by Amjad on 25/10/2018.
//  Copyright © 2018 Amjad. All rights reserved.
//

import Foundation
import UIKit

struct Config {
    
    //MARK: - API End Points
    static let MANAGE_USERS_ENDPOINT = "users"
    static let MOVIES_ENDPOINT = "movies"
    static let TV_SERIESES_ENDPOINT = "tv-serieses"
    static let BOOKS_ENDPOINT = "books"
    static let ITEM_IMAGES_ENDPOINT = "item-images"
    
    //MARK: - Application Colors
    static let MAIN_COLOR = UIColor(red:0.63, green:0.62, blue:0.93, alpha:1.0)
    static let SECONDARY_COLOR = UIColor(red:0.78, green:0.79, blue:0.97, alpha:1.0)
    
    //MARK: - Static Functions
    static func displayAlert(_ viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func displayAlertWithHandler(_ viewController: UIViewController, title: String, message: String, handler: @escaping (UIAlertAction) -> Void ) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: handler)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}


