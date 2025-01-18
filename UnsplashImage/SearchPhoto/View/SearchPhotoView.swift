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
    let filterCollectionView = UICollectionView()
    let imageCollectionView = UICollectionView()
    let toggle = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.naviItem.title = "사진 검색하기"
        
        self.naviBar.tintColor = .label
        self.naviBar.standardAppearance = .init()
    }
    
    override func configHierarchy() {
        self.addSubview(filterCollectionView)
        self.addSubview(imageCollectionView)
        self.addSubview(toggle)
    }
    
    override func configLayout() {
        filterCollectionView.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionView.snp.bottom)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        toggle.snp.makeConstraints {
            $0.centerY.equalTo(filterCollectionView)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(-15)
        }
    }
    
    override func configView() {
        backgroundColor = .systemBackground
        
        // TODO: 각 컬렉션뷰의 collectionViewCell Register
        
        // 토글 선택지 (버튼) enum으로 관리하자
    }
    
    func configSearchbar() {
        self.naviItem.searchController = searchController
        self.naviItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.searchBar.searchBarStyle = .minimal
    }
}
