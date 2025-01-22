//
//  UIViewController+Extension.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit

extension UIViewController {
    
    func alertMessage(message: String) {
        let message = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "확인", style: .cancel)
        
        message.addAction(okay)
        present(message, animated: true)
    }

}


/*
 200 - OK    Everything worked as expected
 400 - Bad Request    The request was unacceptable, often due to missing a required parameter
 401 - Unauthorized    Invalid Access Token
 403 - Forbidden    Missing permissions to perform request
 404 - Not Found    The requested resource doesn’t exist
 500, 503    Something went wrong on our end
 */
