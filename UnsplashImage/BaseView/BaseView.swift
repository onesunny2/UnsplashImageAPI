//
//  BaseView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit

class BaseView: UIView {
    
    // ❔ 모든 뷰에서 navigationController가 사용될 것 같아 여기에 심어뒀는데 괜찮을까요?
    let naviBar = UINavigationBar()
    let naviItem = UINavigationItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configHierarchy()
        configLayout()
        configView()
    }
    
    func configHierarchy() {}
    func configLayout() {}
    func configView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
