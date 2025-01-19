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
    
    private var total = 0
    private var keyword = ""
    private var page = 1
    private var isEnd = false
    var sort = FilterButton.Filter.relevant.labelText
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

        view.backgroundColor = .systemBackground
        
        configNavigation()
        setCollectionView()
        mainView.toggle.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }

    func getPhotoData() {
        
        guard let apiKey = Bundle.main.apiKey else { return }
        print(apiKey)
        
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=\(page)&per_page=20&order_by=\(sort)&color=black&client_id=\(apiKey)"
   
        networkManager.callRequest(url: url) { data in
            
            guard let result = try? self.networkManager.decoder.decode(PhotoSearch.self, from: data) else { return print("decoding failed") }

            self.total = result.total
            
            if self.total == 0 {
                self.mainView.imageCollectionView.isHidden = true
                self.mainView.defaultLabel.text = "검색결과가 없어요(영어만 인식해요!)"
            } else {
                self.mainView.imageCollectionView.isHidden = false
            }
            
            switch self.page {
            case 1:
                self.resultList = result.results
            default:
                if self.page <= result.total_pages {
                    self.resultList += result.results
                    self.isEnd = true
                } else {
                    break
                }
            }
        }
    }
    
    @objc
    func filterButtonTapped(button: UIButton) {

        guard let filterButton = button as? FilterButton else { return }
        
        switch filterButton.filterType {
        case .relevant:
            page = 1
            filterButton.configFilterButton(type: .latest)
            sort = FilterButton.Filter.latest.orderParameter
            removeList()
        case .latest:
            page = 1
            filterButton.configFilterButton(type: .relevant)
            sort = FilterButton.Filter.relevant.orderParameter
            removeList()
        }
        
    }
    
    func removeList() {
        resultList.removeAll()
        getPhotoData()
        scrollUp()
    }
    
    func scrollUp() {
        DispatchQueue.main.async {
            if self.resultList.count != 0 {
                self.mainView.imageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
        }
    }

}

// MARK: - Prefetching
extension SearchPhotoViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if (resultList.count - 4 == item.row) && isEnd == false {
                page += 1
                getPhotoData()
            }
            // ❔ prefetching의 특성 상 item.row가 마지막이 되기 전에 이미 감지?를 해서 원하는 딱 마지막에 alert가 안뜨는데 이 시점을 어떻게 맞출 수 있나요?
            else if isEnd && (resultList.count - 1 == item.row) {
                print("마지막페이지")
                alertMessage(message: "마지막 페이지입니다!")
            }
        }
    }
}

// MARK: - searchBar 관련 처리
extension SearchPhotoViewController {
    
    func configNavigation() {
        navigationItem.title = "사진 검색하기"
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backButtonTitle = ""
        
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
        
        switch resultList.count {
        case 0:
            keyword = text
            getPhotoData()
        default:
            page = 1
            keyword = text
            removeList()
        }

    }
}

// MARK: - CollectionView 관리
extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        mainView.imageCollectionView.delegate = self
        mainView.imageCollectionView.dataSource = self
        mainView.imageCollectionView.prefetchDataSource = self
        mainView.imageCollectionView.isHidden = true
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = resultList[indexPath.row]
        
        print(row.user.name)
        print(row.user.profile.medium)
        
        let vc = SearchPhotoDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.userId = row.id
        vc.userImage = row.user.profile.medium
        vc.userName = row.user.name
        vc.uploadDate = row.uploadDate
        vc.mainImage = row.urls.small
        vc.width = row.width
        vc.height = row.height
    }
}
