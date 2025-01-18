//
//  SearchPhotoViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit
import Alamofire

class SearchPhotoViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)  // 서치바는 BaseView를 토대로 그려지지 못함. ❔NavigationController는 VC에 연결하는 컨트롤러라서 뷰컨에서 그리고 설정해야하는건가?
    
    let networkManager = NetworkingManager.shared
    var mainView = SearchPhotoView()
    
    var total = 0
    var keyword = ""
    var resultList: [PhotoResult] = [] {
        didSet {
            print("resultList")
            mainView.imageCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configNavigation()
        
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        
        mainView.imageCollectionView.isHidden = true
    }

    func getPhotoData() {
        
        guard let apiKey = Bundle.main.apiKey else { return }
        print(apiKey)
        
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=1&per_page=20&order_by=latest&color=yellow&client_id=\(apiKey)"
   
        networkManager.callRequest(url: url) { data in
            
            guard let result = try? self.networkManager.decoder.decode(PhotoSearch.self, from: data) else { return print("decoding failed") }
            
            self.resultList = result.results
            self.total = result.total
            
            if self.total == 0 {
                self.mainView.imageCollectionView.isHidden = true
                self.mainView.defaultLabel.text = "검색결과가 없어요ㅜㅜ"
            } else {
                self.mainView.imageCollectionView.isHidden = false
            }
        }
    }

}

// MARK: - searchBar 관련 처리
extension SearchPhotoViewController {
    
    func configNavigation() {
        navigationItem.title = "사진 검색하기"
        navigationController?.navigationBar.tintColor = .label
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        mainView.imageCollectionView.isHidden = false
        
        guard let text = searchBar.text else { return }
        
        keyword = text
        getPhotoData()

    }
}

// MARK: - CollectionView 관리
extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = resultList[indexPath.row]
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPhotoListCollectionViewCell", for: indexPath) as? SearchPhotoListCollectionViewCell else { print("error")
            return UICollectionViewCell() }
        
        cell.getImageUrl(url: row.urls.small)
        
        let like = row.likes.formatted()
        cell.getLikeCount(count: String(like))
        
        return cell
    }
    
    
}
