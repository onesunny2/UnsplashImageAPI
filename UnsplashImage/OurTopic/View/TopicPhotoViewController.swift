//
//  TopicPhotoViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit

class TopicPhotoViewController: UIViewController {
    
    let networkingManager = NetworkingManager.shared
    private let mainView = TopicPhotoView()
    private var threeTopics: [Topic] = []
    private var firstList: [PhotoTopic] = [] {
        didSet {
            mainView.firstCollectionView.reloadData()
        }
    }
    private var secondList: [PhotoTopic] = [] {
        didSet {
            mainView.secondCollectionView.reloadData()
        }
    }
    private var thirdList: [PhotoTopic] = [] {
        didSet {
            mainView.thirdCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setCollectionView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "돌려돌려 랜덤 TOPIC"
        
        threeTopics = Array(Topic.allCases.shuffled().prefix(3))
        print(threeTopics)
        
        for index in 0...2 {
            getImageData(topicQuery: threeTopics[index].queryParameter)
        }
        
        mainView.firstLabel.text = threeTopics[0].name
        mainView.secondLabel.text = threeTopics[1].name
        mainView.thirdLabel.text = threeTopics[2].name
    }
    
    func getImageData(topicQuery: String) {
        
        guard let apiKey = Bundle.main.apiKey else { return }
        
        let url = "https://api.unsplash.com/topics/\(topicQuery)/photos?page=1&client_id=\(apiKey)"
        
        networkingManager.callRequest(url: url) { data in
            guard let result = try? self.networkingManager.decoder.decode([PhotoTopic].self, from: data) else { return }
            
            switch topicQuery {
            case self.threeTopics[0].queryParameter:
                self.firstList = Array(result.prefix(10))
            case self.threeTopics[1].queryParameter:
                self.secondList = Array(result.prefix(10))
            case self.threeTopics[2].queryParameter:
                self.thirdList = Array(result.prefix(10))
            default:
                print("default")
                break
            }
        }
    }

}

extension TopicPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setCollectionView() {
        mainView.firstCollectionView.delegate = self
        mainView.firstCollectionView.dataSource = self
        mainView.secondCollectionView.delegate = self
        mainView.secondCollectionView.dataSource = self
        mainView.thirdCollectionView.delegate = self
        mainView.thirdCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case mainView.firstCollectionView:
            return firstList.count
        case mainView.secondCollectionView:
            return secondList.count
        case mainView.thirdCollectionView:
            return thirdList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.id, for: indexPath) as? BaseCollectionViewCell else { return UICollectionViewCell() }
        
        switch collectionView {
        case self.mainView.firstCollectionView:
            
            let row = firstList[indexPath.row]
 
            cell.configCell(corner: 15)
            cell.getImageUrl(url: row.urls.small)
            
            let count = String(row.likes.formatted())
            cell.getLikeCount(count: count)
            
            return cell
            
        case self.mainView.secondCollectionView:
            let row = secondList[indexPath.row]

            cell.configCell(corner: 15)
            cell.getImageUrl(url: row.urls.small)
            
            let count = String(row.likes.formatted())
            cell.getLikeCount(count: count)
            
            return cell
            
        case self.mainView.thirdCollectionView:
            let row = thirdList[indexPath.row]

            cell.configCell(corner: 15)
            cell.getImageUrl(url: row.urls.small)
            
            let count = String(row.likes.formatted())
            cell.getLikeCount(count: count)
            
            return cell
            
        default:
            print("default")
            return UICollectionViewCell()
        }
    }
    
    
}

extension TopicPhotoViewController {
    
    enum Topic: CaseIterable {
        case architectureInterior, goldenHour, wallpapers, nature, renders, travel, texturesPatterns, streetPhotography, film, archival, experimental, animals, fashionBeauty, people, businessWork,foodDrink
        
        var name: String {
            switch self {
            case .architectureInterior: "건축 및 인테리어"
            case .goldenHour: "골든 아워"
            case .wallpapers: "배경 화면"
            case .nature: "자연"
            case .renders: "3D 렌더링"
            case .travel: "여행하다"
            case .texturesPatterns: "텍스쳐 및 패턴"
            case .streetPhotography: "거리 사진"
            case .film: "필름"
            case .archival: "기록의"
            case .experimental: "실험적인"
            case .animals: "동물"
            case .fashionBeauty: "패션 및 뷰티"
            case .people: "사람"
            case .businessWork: "비즈니스 및 업무"
            case .foodDrink: "식음료"
            }
        }
        
        var queryParameter: String {
            switch self {
            case .architectureInterior: return "architecture-interior"
            case .goldenHour: return "golden-hour"
            case .wallpapers: return "wallpapers"
            case .nature: return "nature"
            case .renders: return "3d-renders"
            case .travel: return "travel"
            case .texturesPatterns: return "textures-patterns"
            case .streetPhotography: return "street-photography"
            case .film: return "film"
            case .archival: return "archival"
            case .experimental: return "experimental"
            case .animals: return "animals"
            case .fashionBeauty: return "fashion-beauty"
            case .people: return "people"
            case .businessWork: return "business-work"
            case .foodDrink: return "food-drink"
            }
        }
    }
}
