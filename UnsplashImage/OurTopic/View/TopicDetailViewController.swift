//
//  TopicDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/20/25.
//

import UIKit
import SnapKit

final class TopicDetailViewController: UIViewController {
    
    static let id = "TopicDetailViewController"
    private let mainView: BaseDetailView
    let networkingManager = NetworkingManager.shared
    
    private var ratio: CGFloat
    private let photoTopic: PhotoTopic
    
    init(photoTopic: PhotoTopic, ratio: CGFloat) {
        self.photoTopic = photoTopic
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
        mainView.getImageUrl(user: photoTopic.user.profile.medium, thum: photoTopic.urls.small)
        mainView.userNameLabel.text = photoTopic.user.name
        mainView.uploadDateLabel.text = photoTopic.uploadDate
        
//        getInfoData()
        getInfoFromGeneric()
    }
 
    /* func getInfoData() {
 
        networkingManager.callRequest(api: .statistics(userId: photoTopic.id)) { data in
            
            guard let result = try? self.networkingManager.decoder.decode(Statistics.self, from: data) else { return }
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
            self.mainView.sizeDetailLabel.text = String(self.photoTopic.width.formatted()) + " x " + String(self.photoTopic.height.formatted())
        }{
    } */
    
    func getInfoFromGeneric() {
        networkingManager.callRequestByGeneric(type: Statistics.self, api: .statistics(userId: photoTopic.id)) { result in
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
            self.mainView.sizeDetailLabel.text = String(self.photoTopic.width.formatted()) + " x " + String(self.photoTopic.height.formatted())
        } failHandler: { statusCode in
            print("호출 실패했습니다")
            self.alertMessage(code: statusCode.codeNumber, message: statusCode.alertMessage)
        }

    }

}
