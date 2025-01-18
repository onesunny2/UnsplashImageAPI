//
//  FilterButton.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit

class FilterButton: UIButton {
    
    var config = UIButton.Configuration.filled()
    
    init(type: Filter = .relevant) {
        super.init(frame: .zero)
        
        configFilterButton()
    }
    
    func configFilterButton() {
        
        let contaier = AttributeContainer().font(.systemFont(ofSize: 15, weight: .bold))
        
        config.image = UIImage(systemName: "list.bullet")
        config.imagePadding = 5
        config.attributedTitle = AttributedString(Filter.relevant.labelText, attributes: contaier)
        config.cornerStyle = .capsule
        config.baseForegroundColor = .label
        config.baseBackgroundColor = .systemBackground
        config.background.strokeColor = .gray
        config.background.strokeWidth = 1
        
        self.configuration = config
    }
    
    func switchTitle() {
        
        let contaier = AttributeContainer().font(.systemFont(ofSize: 15, weight: .bold))
        let title = (Filter.relevant.labelText == self.currentTitle) ? Filter.latest.labelText : Filter.relevant.labelText
        
        config.attributedTitle = AttributedString(title, attributes: contaier)
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
