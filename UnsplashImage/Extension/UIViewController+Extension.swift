//
//  UIViewController+Extension.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit

extension UIViewController {
    
    func alertMessage(code: Int, message: String) {
        let message = UIAlertController(title: "StatusCode: \(code)", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "확인", style: .cancel)
        
        message.addAction(okay)
        present(message, animated: true)
    }

}
