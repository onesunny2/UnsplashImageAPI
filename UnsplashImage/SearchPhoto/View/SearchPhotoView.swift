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
    var colorButton: [ColorButton] = []
    
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
        
        for _ in 0...ColorButton.Color.allCases.count - 1 {
            colorButton.append(ColorButton())
        }
        
        let type = ColorButton.Color.allCases
        for index in 0...colorButton.count - 1 {
            colorButton[index].configColorButton(type: type[index])
            if index == 0 {
                colorButton[index].configuration?.baseForegroundColor = .white
                colorButton[index].configuration?.baseBackgroundColor = .darkGray
            }
        }
        
        super.init(frame: frame)
        imageCollectionView.collectionViewLayout = imageCollectionViewFlowLayout()
    }
    
    override func configHierarchy() {
        self.addSubview(defaultLabel)
        self.addSubview(imageCollectionView)
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        colorButton.forEach {
            stackView.addArrangedSubview($0)
        }
        self.addSubview(toggle)
    }
    
    override func configLayout() {
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            
            let padding = UIScreen.main.bounds.width * 0.25
            
            $0.verticalEdges.equalTo(scrollView)
            $0.leading.equalTo(scrollView).inset(16)
            $0.trailing.equalTo(scrollView).inset(padding)
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
            $0.centerY.equalTo(stackView)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(100)
            $0.height.equalTo(35)
        }
    }
    
    override func configView() {
        backgroundColor = .systemBackground
        scrollView.backgroundColor = .systemBackground
        scrollView.showsHorizontalScrollIndicator = false
        stackView.backgroundColor = .clear
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        defaultLabel.text = "사진을 검색해 보세요!"
        defaultLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        imageCollectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.id)
    }
}
