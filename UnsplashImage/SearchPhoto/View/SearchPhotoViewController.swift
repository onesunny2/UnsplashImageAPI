//
//  SearchPhotoViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit
import Alamofire

class SearchPhotoViewController: UIViewController {
    
    let networkManager = NetworkingManager.shared
    var mainView = SearchPhotoView()
    
    var keyword = "cat"
    var resultList: [PhotoResult] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        getPhotoData()
        
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        
        mainView.imageCollectionView.register(SearchPhotoListCollectionViewCell.self, forCellWithReuseIdentifier: "SearchPhotoListCollectionViewCell")
    }

    func getPhotoData() {
        
        guard let apiKey = Bundle.main.apiKey else { return }
        print(apiKey)
        
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=1&per_page=20&order_by=latest&color=yellow&client_id=\(apiKey)"
   
        networkManager.callRequest(url: url) { data in
            
            guard let result = try? self.networkManager.decoder.decode(PhotoSearch.self, from: data) else { return print("decoding failed") }
            
            self.resultList = result.results
            
            self.mainView.imageCollectionView.reloadData()
            
        }
    }
}

extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(resultList.count)
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPhotoListCollectionViewCell", for: indexPath) as? SearchPhotoListCollectionViewCell else { print("error")
            return UICollectionViewCell() }
        
        print("durl")
        
        return cell
    }
    
    
}
