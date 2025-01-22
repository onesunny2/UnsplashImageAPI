//
//  SearchPhotoDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit

final class SearchPhotoDetailViewController: UIViewController {
    
    static let id = "SearchPhotoDetailViewController"
    let networkManager = NetworkingManager.shared
    
    private var mainView: BaseDetailView
    private var ratio: CGFloat
    private let photoResult: PhotoResult
    
    
    // 🌱💛 할 수 있는데 할 수 있는건지 몰랐던 부분을 숙제로 내주신 덴님께 감사를 드립니다... :D 덕분에 이제 init으로 데이터 넘기기가 친근해졌어요
    init(photoResult: PhotoResult, ratio: CGFloat) {
        self.photoResult = photoResult
        self.ratio = ratio
        self.mainView = BaseDetailView(ratio: ratio)
        
        // ❔그냥 super.init()으로 실행하면 해당 화면에 진입하는 순간 앱이 터지는데, 혹시 ViewController 자체가 스토리보드에서도 구현이 가능하기 때문에 필수로 파라미터로 적어야하는건가요? 마치 required init이 스토리보드의 영향으로 무조건 넣어야하는 것 처럼요!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
 
        mainView.userNameLabel.text = photoResult.user.name
        mainView.uploadDateLabel.text = photoResult.uploadDate.changeDate()
        mainView.getImageUrl(user: photoResult.user.profile.medium, thum: photoResult.urls.small)
        mainView.sizeDetailLabel.text = String(photoResult.width.formatted()) + " x " + String(photoResult.height.formatted())

        getInfoFromGeneric()
    }
    
    /* func getInfoData() {

        networkManager.callRequest(api: .statistics(userId: userId)) { data in
            
            guard let result = try? self.networkManager.decoder.decode(Statistics.self, from: data) else { return print("decoding error") }
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
        }
    } */
    
    func getInfoFromGeneric() {
        networkManager.callRequestByGeneric(type: Statistics.self, api: .statistics(userId: photoResult.id)) { result in
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
            
        } failHandler: {
            print("호출 오류우우우우")
        }

    }

}
