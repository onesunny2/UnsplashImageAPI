//
//  ImageReelsViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/21/25.
//

import UIKit

class ImageReelsViewController: UIViewController {
    
    private let mainView = ImageReelsView()
    
    private var randoms: [RandomPhoto] = []
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        
//        navigationController?.isNavigationBarHidden = true
//        navigationController?.isToolbarHidden = true
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                navigationController?.isNavigationBarHidden = true
                navigationController?.isToolbarHidden = true
    }

}

// MARK: CollectionView 세팅
extension ImageReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageReelsCollectionViewCell.id, for: indexPath) as? ImageReelsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemGreen
        
        return cell
    }
    
    
}
