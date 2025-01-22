//
//  TabBarController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        setupTabBarAppearance()
    }
    
    func configureTabBarController() {
        let firstVc = UINavigationController(rootViewController: TopicPhotoViewController())
        firstVc.tabBarItem.title = ""
        firstVc.tabBarItem.image = UIImage(systemName: "folder")
        firstVc.tabBarItem.selectedImage = UIImage(systemName: "folder.fill")
        
        
        let secondVc = UINavigationController(rootViewController: ImageReelsViewController())
        secondVc.tabBarItem.title = ""
        secondVc.tabBarItem.image = UIImage(systemName: "star")
        secondVc.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
//        secondVc.isNavigationBarHidden = true
//        secondVc.isToolbarHidden = true
        
        let thirdVc = UINavigationController(rootViewController: SearchPhotoViewController())
        thirdVc.tabBarItem.title = ""
        thirdVc.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        thirdVc.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        let fourthVc = UINavigationController(rootViewController: LikePhotoViewController())
        fourthVc.tabBarItem.title = ""
        fourthVc.tabBarItem.image = UIImage(systemName: "heart")
        fourthVc.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        
        setViewControllers([firstVc, secondVc, thirdVc, fourthVc], animated: true)
    }
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .label
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
}
