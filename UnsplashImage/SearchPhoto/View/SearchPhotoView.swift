//
//  SearchPhotoView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit
import SnapKit

class SearchPhotoView: BaseView {

    let toggle = FilterButton()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var imageCollectionView: UICollectionView
    let defaultLabel = UILabel()
    
    func imageCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let sectionInsect: CGFloat = 0
        let cellSpacing: CGFloat = 3  // default: 10
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - (sectionInsect * 2 + cellSpacing)) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 1.5))
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionInsect, left: sectionInsect, bottom: sectionInsect, right: sectionInsect)
        
        return layout
    }


    override init(frame: CGRect) {
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        super.init(frame: frame)
        
        imageCollectionView.collectionViewLayout = imageCollectionViewFlowLayout()
    }
    
    override func configHierarchy() {
        self.addSubview(imageCollectionView)
        self.addSubview(defaultLabel)
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        self.addSubview(toggle)
    }
    
    override func configLayout() {
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(50)
        }
        
        defaultLabel.snp.makeConstraints {
            $0.center.equalTo(imageCollectionView)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        toggle.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).inset(5)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(5)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(100)
        }
    }
    
    override func configView() {
        backgroundColor = .systemBackground
        scrollView.backgroundColor = .systemBackground
        stackView.backgroundColor = .clear
        
        stackView.axis = .horizontal
        stackView.spacing = 10

        stackLabel()
        
        defaultLabel.text = "사진을 검색해 보세요!"
        defaultLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        imageCollectionView.register(SearchPhotoListCollectionViewCell.self, forCellWithReuseIdentifier: "SearchPhotoListCollectionViewCell")
    }
    
    func stackLabel() {
        let label = UILabel()
        label.backgroundColor = .systemIndigo
        label.text = "컬러버튼 자리입니다"
        stackView.addArrangedSubview(label)
        
        let label2 = UILabel()
        label2.backgroundColor = .systemOrange
        label2.text = "컬러버튼 자리입니다"
        stackView.addArrangedSubview(label2)
        
        let label3 = UILabel()
        label3.backgroundColor = .systemGray
        label3.text = "컬러버튼 자리입니다"
        stackView.addArrangedSubview(label3)
        
        let label4 = UILabel()
        label4.backgroundColor = .systemBrown
        label4.text = "컬러버튼 자리입니다"
        stackView.addArrangedSubview(label4)
    }
}
