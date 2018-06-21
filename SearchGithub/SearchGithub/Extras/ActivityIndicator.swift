//
//  ActivityIndicator.swift
//  SearchGitHub
//
//  Created by Abhisek on 6/17/18.
//  Copyright © 2018 Abhisek. All rights reserved.
//

import UIKit
import Foundation

class ActivityIndicator {
    
    class func displayActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    class func hideActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

class Helper {
    
    class func showAlert(message: String, title: String) {
        guard let rootController = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        rootController.present(alert, animated: true, completion: nil)
    }
    
}
