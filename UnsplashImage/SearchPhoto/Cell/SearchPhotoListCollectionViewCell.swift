//
//  SearchPhotoCollectionViewCell.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit
import Kingfisher
import SnapKit

class SearchPhotoListCollectionViewCell: UICollectionViewCell {
    
    static let id = "SearchPhotoListCollectionViewCell"
    
    let thumImage = UIImageView()
    let likeBgView = UIView()
    let likeLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemIndigo
        configImage()
        configLike()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        
        // cornerRadius 넣는 자리
        thumImage.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        
        // ❔layoutSubview는 이미 객체의 프레임이 다 잡히고 실행한다고 알고있고, 이미 메인에서 동작하고 있는데 왜 강제로 지연시키기 않으면 cornerRadius가 들지 않나요?
        DispatchQueue.main.async {
            self.likeBgView.layer.cornerRadius = self.likeBgView.frame.height / 2
            self.likeBgView.clipsToBounds = true
        }
    }
}

extension SearchPhotoListCollectionViewCell {
    
    func configImage() {
        contentView.addSubview(thumImage)
        
        thumImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        thumImage.contentMode = .scaleAspectFill
    }
    
    func configLike() {
        contentView.addSubview(likeBgView)
        likeBgView.addSubview(likeLabel)
        
        likeBgView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(15)
            $0.height.equalTo(30)
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        likeLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        
        likeBgView.backgroundColor = .darkGray
        likeLabel.textColor = .white
        likeLabel.numberOfLines = 1
        likeLabel.textAlignment = .center
        likeLabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    func getImageUrl(url: String) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: thumImage.frame.width, height: thumImage.frame.height))

        thumImage.kf.setImage(with: URL(string: url),
                              options: [
                                .processor(processor),
                                .scaleFactor(UIScreen.main.scale),
                                .cacheOriginalImage
                              ])
    }
    
    func getLikeCount(count: String) {
        likeLabel.text = "⭐️ \(count)"
    }
}
