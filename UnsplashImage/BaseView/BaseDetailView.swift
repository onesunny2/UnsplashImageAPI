//
//  BaseDetailView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit
import SnapKit

class BaseDetailView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    lazy var userStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        return stackView
    }()
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    let uploadDateLabel = UILabel()
    let mainImageView = UIImageView()
    let infoLabel = UILabel()
    let sizeStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    let sizeLabel = UILabel()
    let sizeDetailLabel = UILabel()
    let viewCountStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    let viewCountLabel = UILabel()
    let viewCountDatailLabel = UILabel()
    let downloadStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    let downloadLabel = UILabel()
    let downloadDetailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configHierarchy()
        configLayout()
        configView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 프로필사진 cornerRadious 처리
    }
    
    override func configHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [userImageView, mainImageView, infoLabel, userStackView, sizeStackView, viewCountStackView, downloadStackView].forEach {
            contentView.addSubview($0)
        }
        
        userStackView.addArrangedSubview(userNameLabel)
        userStackView.addArrangedSubview(uploadDateLabel)
        sizeStackView.addArrangedSubview(sizeLabel)
        sizeStackView.addArrangedSubview(sizeDetailLabel)
        viewCountStackView.addArrangedSubview(viewCountLabel)
        viewCountStackView.addArrangedSubview(viewCountDatailLabel)
        downloadStackView.addArrangedSubview(downloadLabel)
        downloadStackView.addArrangedSubview(downloadDetailLabel)
    }
    
    override func configLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        userImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(30)
        }
        
        userStackView.snp.makeConstraints {
            $0.centerY.equalTo(userImageView)
            $0.leading.equalTo(userImageView.snp.trailing).offset(10)
        }
        
        userStackView.spacing = 4
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(mainImageView.snp.bottom).offset(16)
        }
        
        sizeStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(50)
            $0.centerY.equalTo(infoLabel)
        }
        
        sizeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        sizeDetailLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        viewCountStackView.snp.makeConstraints {
            $0.top.equalTo(sizeStackView.snp.bottom).offset(14)
            $0.horizontalEdges.equalTo(sizeStackView.snp.horizontalEdges)
        }
        
        viewCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        viewCountDatailLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        downloadStackView.snp.makeConstraints {
            $0.top.equalTo(viewCountStackView.snp.bottom).offset(14)
            $0.horizontalEdges.equalTo(viewCountStackView.snp.horizontalEdges)
        }
        
        downloadLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        downloadDetailLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
    }
    
    override func configView() {
        <#code#>
    }
    

}
