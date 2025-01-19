//
//  TopicPhotoView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit
import Kingfisher
import SnapKit

class TopicPhotoView: BaseView {
    
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
        [firstLabel, firstCollectionView, secondLabel, secondCollectionView, thirdLabel, thirdCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configLayout() {
        firstLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        firstCollectionView.snp.makeConstraints {
            
            let cellHeight = (UIScreen.main.bounds.width / 2 - 40) * 1.3
            
            $0.top.equalTo(firstLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(cellHeight)
        }
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(firstCollectionView.snp.bottom).offset(18)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        secondCollectionView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(secondCollectionView.snp.bottom).offset(18)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        thirdCollectionView.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(12)
            $0.bottom.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configView() {
        firstLabel.detailLabel(text: "", size: 18, weight: .bold)
        secondLabel.detailLabel(text: "", size: 18, weight: .bold)
        thirdLabel.detailLabel(text: "", size: 18, weight: .bold)
        
        firstCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
        secondCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
        thirdCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
    }
}
