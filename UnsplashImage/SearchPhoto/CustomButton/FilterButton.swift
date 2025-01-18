//
//  FilterButton.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit

class FilterButton: UIButton {
    
    var config = UIButton.Configuration.filled()
    var filterType: Filter
    
    init() {
        self.filterType = .relevant
        super.init(frame: .zero)
        
        configFilterButton()
    }
    
    func configFilterButton(type: Filter = .relevant) {
        
        let contaier = AttributeContainer().font(.systemFont(ofSize: 15, weight: .bold))
        
        filterType = type
        
        config.image = UIImage(systemName: "list.bullet")
        config.imagePadding = 5
        config.attributedTitle = AttributedString(type.labelText, attributes: contaier)
        config.cornerStyle = .capsule
        config.baseForegroundColor = .label
        config.baseBackgroundColor = .systemBackground
        config.background.strokeColor = .gray
        config.background.strokeWidth = 1
        
        self.configuration = config
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterButton {
    
    enum Filter {
        case relevant
        case latest
        
        var labelText: String {
            switch self {
            case .relevant: "관련순"
            case .latest: "최신순"
            }
        }
        
        var orderParameter: String {
            switch self {
            case .relevant: "relevant"
            case .latest: "latest"
            }
        }
    }
}
