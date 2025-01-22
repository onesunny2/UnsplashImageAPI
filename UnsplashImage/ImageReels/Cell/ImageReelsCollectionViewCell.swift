//
//  ImageReelsCollectionViewCell.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/22/25.
//

import UIKit
import Kingfisher
import SnapKit

class ImageReelsCollectionViewCell: UICollectionViewCell {
    
    static let id = "ImageReelsCollectionViewCell"
    
    let mainImageView = UIImageView()
    let numberBgView = UIView()
    let numberLabel = UILabel()
    let userImageView = UIImageView()
    let userLabelStackView = UIStackView()
    let usernameLabel = UILabel()
    let postDateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configHierarchy()
        configLayout()
        configView()
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            self.numberBgView.layer.cornerRadius = self.numberBgView.frame.height / 2
            self.numberBgView.clipsToBounds = true
            
            self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
            self.userImageView.clipsToBounds = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ImageReelsCollectionViewCell {
    func configHierarchy() {
        [mainImageView, numberBgView, userImageView, userLabelStackView].forEach {
            self.addSubview($0)
        }
        
        numberBgView.addSubview(numberLabel)
        userLabelStackView.addArrangedSubview(usernameLabel)
        userLabelStackView.addArrangedSubview(postDateLabel)
    }
    
    func configLayout() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        numberBgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.lessThanOrEqualToSuperview()
            $0.height.equalTo(16)
        }
        
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        userImageView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(16)
            $0.size.equalTo(25)
        }
        
        userLabelStackView.snp.makeConstraints {
            $0.centerY.equalTo(userImageView)
            $0.leading.equalTo(userImageView).offset(10)
        }
        
        userLabelStackView.axis = .vertical
        userLabelStackView.spacing = 8
        
        usernameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        postDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
    }
    
    func configView() {
        mainImageView.contentMode = .scaleAspectFill
        
        numberBgView.backgroundColor = .darkGray
        numberLabel.detailLabel(text: "1/10", alignment: .center, size: 13, weight: .regular)
        
        userImageView.contentMode = .scaleAspectFill
        usernameLabel.detailLabel(text: "", size: 13, weight: .regular)
        postDateLabel.detailLabel(text: "", size: 13, weight: .semibold)
    }
    
    func getMainImageData(main: String) {
        
        guard let mainUrl = URL(string: main) else { return }
        guard let data = try? Data(contentsOf: mainUrl) else { return }
        guard let image = UIImage(data: data) else { return }
        mainImageView.image = image
    }
    
    func getUserImageData(user: String) {
        
        guard let userUrl = URL(string: user) else { return }
        guard let data = try? Data(contentsOf: userUrl) else { return }
        guard let image = UIImage(data: data) else { return }
        userImageView.image = image
    }
}
