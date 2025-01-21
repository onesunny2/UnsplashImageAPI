//
//  TopicDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/20/25.
//

import UIKit

class TopicDetailViewController: UIViewController {
    
    static let id = "TopicDetailViewController"
    lazy var mainView = BaseDetailView(ratio: ratio)
    let networkingManager = NetworkingManager.shared
    
    var userId = ""
    var userImage = ""
    var userName = ""
    var uploadDate = ""
    var mainImage = ""
    var width = 0
    var height = 0
    var ratio: CGFloat = 0

    override func loadView() {
        ratio = CGFloat(height) / CGFloat(width)
        print(ratio)
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .systemBackground
        mainView.getImageUrl(user: userImage, thum: mainImage)
        mainView.userNameLabel.text = userName
        mainView.uploadDateLabel.text = uploadDate
        
        getInfoData()
    }
 
    func getInfoData() {
 
        networkingManager.callRequest(api: .statistics(userId: userId)) { data in
            
            guard let result = try? self.networkingManager.decoder.decode(Statistics.self, from: data) else { return }
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
            self.mainView.sizeDetailLabel.text = String(self.width.formatted()) + " x " + String(self.height.formatted())
        }
    }

}
