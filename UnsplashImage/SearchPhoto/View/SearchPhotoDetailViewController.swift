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
    
    func getInfoFromGeneric() {
        networkManager.callRequestByGeneric(type: Statistics.self, api: .statistics(userId: photoResult.id)) { result in
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
            
        } failHandler: { statusCode in
            print("호출 오류우우우우")
            self.alertMessage(code: statusCode.codeNumber, message: statusCode.alertMessage)
        }

    }

}
