//
//  ImageReelsViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/21/25.
//

import UIKit

class ImageReelsViewController: UIViewController {
    
    let mainView = ImageReelsView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemIndigo
        
        mainView.collectionView.isPagingEnabled = true
    }

}
