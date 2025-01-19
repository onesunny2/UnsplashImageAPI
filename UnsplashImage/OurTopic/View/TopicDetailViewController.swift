//
//  TopicDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/20/25.
//

import UIKit

class TopicDetailViewController: UIViewController {
    
    static let id = "TopicDetailViewController"
    private let mainView = BaseDetailView()
    let networkingManager = NetworkingManager.shared
    
    var userId = ""
    var userImage = ""
    var userName = ""
    var uploadDate = ""
    var mainImage = ""
    var width = 0
    var height = 0

    override func loadView() {
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
        
        guard let apiKey = Bundle.main.apiKey else { return }
        
        let url = "https://api.unsplash.com/photos/\(userId)/statistics?client_id=\(apiKey)"
        
        networkingManager.callRequest(url: url) { data in
            
            guard let result = try? self.networkingManager.decoder.decode(Statistics.self, from: data) else { return }
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
            self.mainView.sizeDetailLabel.text = String(self.width.formatted()) + " x " + String(self.height.formatted())
        }
    }

}
