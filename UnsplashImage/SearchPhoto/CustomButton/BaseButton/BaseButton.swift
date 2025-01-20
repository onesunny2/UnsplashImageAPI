//
//  BaseButton.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/20/25.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func buttonDesign() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
