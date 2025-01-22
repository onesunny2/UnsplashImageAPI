//
//  TopicPhotoView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit

final class TopicPhotoView: BaseView {
    
    let scrollView = UIScrollView()
    let refreshControl = UIRefreshControl()
    private let contentView = UIView()
    let firstCollectionView: UICollectionView
    let firstLabel = UILabel()
    let secondCollectionView: UICollectionView
    let secondLabel = UILabel()
    let thirdCollectionView: UICollectionView
    let thirdLabel = UILabel()
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        
        let sectionInset: CGFloat = 16
        let cellSpacing: CGFloat = 8
        let cellWidth: CGFloat = (UIScreen.main.bounds.width / 2) - 40
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.3)
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: 4)
        
        return layout
    }
    
    override init(frame: CGRect) {
        
        self.firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        super.init(frame: frame)
        
        self.firstCollectionView.collectionViewLayout = collectionViewFlowLayout()
        self.secondCollectionView.collectionViewLayout = collectionViewFlowLayout()
        self.thirdCollectionView.collectionViewLayout = collectionViewFlowLayout()
        configHierarchy()
        configLayout()
        configView()
    }
    
    override func configHierarchy() {
        self.addSubview(scrollView)
        scrollView.addSubview(refreshControl)
        scrollView.addSubview(contentView)
        [firstLabel, firstCollectionView, secondLabel, secondCollectionView, thirdLabel, thirdCollectionView].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    override func configLayout() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.verticalEdges.equalTo(scrollView)
        }
        
        firstLabel.snp.makeConstraints {
            $0.top.leading.equalTo(contentView).inset(16)
        }
        
        firstCollectionView.snp.makeConstraints {
            let cellHeight = (UIScreen.main.bounds.width / 2 - 40) * 1.3
            
            $0.top.equalTo(firstLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(cellHeight)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstCollectionView.snp.bottom).offset(18)
            $0.leading.equalTo(contentView).inset(16)
        }
        
        secondCollectionView.snp.makeConstraints {
            let cellHeight = (UIScreen.main.bounds.width / 2 - 40) * 1.3
            
            $0.top.equalTo(secondLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(cellHeight)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondCollectionView.snp.bottom).offset(18)
            $0.leading.equalTo(contentView).inset(16)
        }
        
        thirdCollectionView.snp.makeConstraints {
            let cellHeight = (UIScreen.main.bounds.width / 2 - 40) * 1.3
            
            $0.top.equalTo(thirdLabel.snp.bottom).offset(12)
            $0.bottom.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(cellHeight)
        }
    }
    
    override func configView() {
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        
        firstLabel.detailLabel(text: "", size: 18, weight: .bold)
        secondLabel.detailLabel(text: "", size: 18, weight: .bold)
        thirdLabel.detailLabel(text: "", size: 18, weight: .bold)
        
        firstCollectionView.showsHorizontalScrollIndicator = false
        secondCollectionView.showsHorizontalScrollIndicator = false
        thirdCollectionView.showsHorizontalScrollIndicator = false
        
        firstCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
        secondCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
        thirdCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
    }
}
