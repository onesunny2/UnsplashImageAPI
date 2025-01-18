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
