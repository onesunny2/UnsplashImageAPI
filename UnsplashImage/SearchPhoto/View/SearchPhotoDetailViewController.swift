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
        } statusHandler: { statusCode in
            guard let message = APIStatus(statusCode: statusCode)?.alertMessage else { return }
            self.alertMessage(code: statusCode, message: message)
        }

    }

}
