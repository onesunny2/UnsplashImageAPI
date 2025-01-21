//
//  ImageReelsView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/22/25.
//

import UIKit
import SnapKit

class ImageReelsView: BaseView {
    
    let collectionView: UICollectionView
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let sectionInset: CGFloat = 0
        let cellSpacing: CGFloat = 0
        let cellwidth = UIScreen.main.bounds.width
        let cellheight = UIScreen.main.bounds.height
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: cellwidth, height: cellheight)
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        
        return layout
    }
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        super.init(frame: frame)
        
        configHierarchy()
        configLayout()
        configView()
        
        collectionView.collectionViewLayout = collectionViewFlowLayout()
    }
    
    override func configHierarchy() {
        self.addSubview(collectionView)
    }
    
    override func configLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        collectionView.register(ImageReelsCollectionViewCell.self, forCellWithReuseIdentifier: "ImageReelsCollectionViewCell")
    }
}
