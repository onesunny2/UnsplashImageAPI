//
//  SearchPhotoView.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/18/25.
//

import UIKit
import SnapKit

class SearchPhotoView: BaseView {
    
    let searchController = UISearchController()
    let toggle = FilterButton()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var imageCollectionView: UICollectionView
    
    func imageCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let sectionInsect: CGFloat = 0
        let cellSpacing: CGFloat = 2
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - (sectionInsect * 2 + cellSpacing)) / 2
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 1.5))
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: sectionInsect, left: sectionInsect, bottom: sectionInsect, right: sectionInsect)
        
        return layout
    }


    override init(frame: CGRect) {
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        super.init(frame: frame)
        
        imageCollectionView.collectionViewLayout = imageCollectionViewFlowLayout()
        self.naviItem.title = "사진 검색하기"
        self.naviBar.tintColor = .label
        self.naviBar.standardAppearance = .init()
        
       
    }
    
    override func configHierarchy() {
        self.addSubview(imageCollectionView)
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
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        toggle.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).inset(10)
            $0.bottom.equalTo(scrollView.snp.bottom).inset(10)
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
        
        configSearchbar()
        stackLabel()
        
//        imageCollectionView.register(SearchPhotoListCollectionViewCell.self, forCellWithReuseIdentifier: "SearchPhotoListCollectionViewCell")
    }
    
    func configSearchbar() {
        self.naviItem.searchController = searchController
        self.naviItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.searchBar.searchBarStyle = .minimal
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
