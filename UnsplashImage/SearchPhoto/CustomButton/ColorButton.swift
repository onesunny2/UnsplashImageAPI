//
//  FilterButton.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit

class ColorButton: UIButton {
    
    var config = UIButton.Configuration.filled()
    var colorType: Color
    
    init() {
        self.colorType = .black
        super.init(frame: .zero)
        configColorButton()
    }
    
    func configColorButton(type: Color = .black) {
        let contaier = AttributeContainer().font(.systemFont(ofSize: 15, weight: .regular))
        
        colorType = type
        
        config.attributedTitle = AttributedString(type.label, attributes: contaier)
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .label
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))?.withTintColor(UIColor(.black), renderingMode: .alwaysOriginal)
        config.imagePadding = 5
        
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorButton {
    
    enum Color: String, CaseIterable {
        case black
        case white
        case yellow
        case red
        case purple
        case green
        case blue
        
        var label: String {
            switch self {
            case .black:
                return "블랙"
            case .white:
                return "화이트"
            case .yellow:
                return "옐로우"
            case .red:
                return "레드"
            case .purple:
                return "퍼플"
            case .green:
                return "그린"
            case .blue:
                return "블루"
            }
        }
        
        var query: String {
            
            switch self {
            default:
                return self.rawValue
            }
//            switch self {
//            case .black:
//                return "black"
//            case .white:
//                return "white"
//            case .yellow:
//                return "yellow"
//            case .red:
//                return "red"
//            case .purple:
//                return "purple"
//            case .green:
//                return "green"
//            case .blue:
//                return "blue"
//            }
        }
    }
}
