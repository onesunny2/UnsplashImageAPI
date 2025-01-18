//
//  SearchPhotoCollectionViewCell.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit

class SearchPhotoListCollectionViewCell: UICollectionViewCell {
    
    static let id = "SearchPhotoListCollectionViewCell"
    
    let thumImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemIndigo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
