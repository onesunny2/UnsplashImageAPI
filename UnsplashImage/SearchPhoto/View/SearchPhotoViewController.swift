//
//  SearchPhotoViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit
import Alamofire

class SearchPhotoViewController: UIViewController {
    
    let networkManager = NetworkingManager.shared
    
    var keyword = "고양이"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemIndigo
    }

    func getPhotoData() {
        
        guard let apiKey = Bundle.main.apiKey else { return }
        
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=1&per_page=20&order_by=latest&color=yellow&client_i=\(apiKey)"
   
        networkManager.callRequest(url: url) { data in
            
            guard let result = try? self.networkManager.decoder.decode([PhotoSearch].self, from: data) else { return print("decoding failed") }
            
            print(result)
            
        }
    }
    
}
