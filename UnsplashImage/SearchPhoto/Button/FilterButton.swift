//
//  FilterButton.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit

class FilterButton: UIButton {
    
    
    init(type: Color) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterButton {
    
    enum Color: Int, CaseIterable {
        case black
        case red
        case yellow
        case green
        
        var label: String {
            switch self {
            case .black:
                return "검정"
            case .red:
                return "빨강"
            case .yellow:
                return "노랑"
            case .green:
                return "초록"
            }
        }
        
        var query: String {
            switch self {
            case .black:
                return "black"
            case .red:
                return "red"
            case .yellow:
                return "yellow"
            case .green:
                return "green"
            }
        }
    }
}
