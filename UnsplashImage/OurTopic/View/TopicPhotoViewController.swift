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
    private var firstList: [PhotoTopic] = []
//    {
//        didSet {
//            mainView.firstCollectionView.reloadData()
//        }
//    }
    private var secondList: [PhotoTopic] = []
//    {
//        didSet {
//            mainView.secondCollectionView.reloadData()
//        }
//    }
    private var thirdList: [PhotoTopic] = []
//    {
//        didSet {
//            mainView.thirdCollectionView.reloadData()
//        }
//    }
    
    var count = 0
    let group = DispatchGroup()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        mainView.scrollView.alwaysBounceVertical = true
        mainView.scrollView.bounces = true
        mainView.scrollView.delegate = self
        setCollectionView()
        setNavigation()
        
        setRandomTopic()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getImageData(topicQuery: String) {
        
        networkingManager.callRequest(api: .topic(topic: topicQuery)) { data in
            guard let result = try? self.networkingManager.decoder.decode([PhotoTopic].self, from: data) else {
                // TODO: 질문하기 - 매니저 안에서 failHandler 처리를 남기면 필요없는 다른 곳에서도 사용해야 해서 여기서 처리하려고 했는데 맞는걸까요?
                self.group.leave()
                self.count -= 1
                print("error", self.count)
                return }
            
            switch topicQuery {
            case self.threeTopics[0].queryParameter:
                self.firstList = Array(result.shuffled().prefix(10))
            case self.threeTopics[1].queryParameter:
                self.secondList = Array(result.shuffled().prefix(10))
            case self.threeTopics[2].queryParameter:
                self.thirdList = Array(result.shuffled().prefix(10))
            default:
                print("default")
                break
            }
            
            self.group.leave()
            self.count -= 1
            print(self.count)
        }
    }
    
    func setNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = "돌려돌려 랜덤 TOPIC"
        navigationItem.backButtonTitle = ""
    }
    
    func setRandomTopic() {
        
        threeTopics = Array(Topic.allCases.shuffled().prefix(3))
        
        for index in 0...2 {
            group.enter()
            count += 1
            print(count)
            getImageData(topicQuery: threeTopics[index].queryParameter)
        }
        
        group.notify(queue: .main) {

            self.mainView.firstCollectionView.reloadData()
            self.mainView.firstLabel.text = self.threeTopics[0].name
            print("1 end")
            self.mainView.secondCollectionView.reloadData()
            self.mainView.secondLabel.text = self.threeTopics[1].name
            print("2 end")
            self.mainView.thirdCollectionView.reloadData()
            self.mainView.thirdLabel.text = self.threeTopics[2].name
            print("3 end")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = TopicDetailViewController()
        
        switch collectionView {
        case mainView.firstCollectionView:
            let row = firstList[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            sendDataToVC(vc: vc, row: row)
        case mainView.secondCollectionView:
            let row = secondList[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            sendDataToVC(vc: vc, row: row)
        case mainView.thirdCollectionView:
            let row = thirdList[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            sendDataToVC(vc: vc, row: row)
        default:
            print(#function, "오류")
            break
        }
    }
    
    func sendDataToVC(vc: TopicDetailViewController, row: PhotoTopic) {
        vc.userId = row.id
        vc.userImage = row.user.profile.medium
        vc.userName = row.user.name
        vc.uploadDate = row.uploadDate.changeDate()
        vc.mainImage = row.urls.small
        vc.width = row.width
        vc.height = row.height
    }
    
}

extension TopicPhotoViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y <= -70 {
            mainView.refreshControl.beginRefreshing()
            print("start refresh")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.setRandomTopic()
            }
            mainView.refreshControl.endRefreshing()
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
