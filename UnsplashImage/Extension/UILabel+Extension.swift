//
//  UILabel+Extension.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit

extension UILabel {
    func detailLabel(text: String, alignment: NSTextAlignment = .left, size: CGFloat, weight: UIFont.Weight) {
        self.text = text
        self.textColor = .label
        self.textAlignment = alignment
        self.numberOfLines = 1
        self.font = .systemFont(ofSize: size, weight: weight)
    }
}
