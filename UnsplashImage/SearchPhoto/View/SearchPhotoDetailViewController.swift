//
//  SearchPhotoDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit

class SearchPhotoDetailViewController: UIViewController {
    
    static let id = "SearchPhotoDetailViewController"
    
    private let mainView = BaseDetailView()
    
    var userId = ""
    var userImage = ""
    var userName = ""
    var uploadDate = ""
    var mainImage = ""
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        mainView.userNameLabel.text = userName
        mainView.uploadDateLabel.text = uploadDate
        mainView.getImageUrl(user: userImage, thum: mainImage)

        getInfoData()
    }
    
    func getInfoData() {
        
    }

}
