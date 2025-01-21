//
//  SearchPhotoDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit

class SearchPhotoDetailViewController: UIViewController {
    
    static let id = "SearchPhotoDetailViewController"
    let networkManager = NetworkingManager.shared
    
    lazy var mainView = BaseDetailView(ratio: ratio)
    
    var userId = ""
    var userImage = ""
    var userName = ""
    var uploadDate = ""
    var mainImage = ""
    var width = 0
    var height = 0
    var ratio: CGFloat = 0
    
    override func loadView() {
        ratio = CGFloat(width) / CGFloat(height)
        print(ratio)
        
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        // TODO: navigation Appearance
        
        mainView.userNameLabel.text = userName
        mainView.uploadDateLabel.text = uploadDate.changeDate()
        mainView.getImageUrl(user: userImage, thum: mainImage)
        mainView.sizeDetailLabel.text = String(width.formatted()) + " x " + String(height.formatted())

        getInfoData()
    }
    
    func getInfoData() {

        networkManager.callRequest(api: .statistics(userId: userId)) { data in
            
            guard let result = try? self.networkManager.decoder.decode(Statistics.self, from: data) else { return print("decoding error") }
            
            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
        }
    }

}
