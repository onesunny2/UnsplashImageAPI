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
    
    var keyword = "cat"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemIndigo
        
        getPhotoData()
    }

    func getPhotoData() {
        
        guard let apiKey = Bundle.main.apiKey else { return }
        print(apiKey)
        
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=1&per_page=20&order_by=latest&color=yellow&client_id=\(apiKey)"
   
        networkManager.callRequest(url: url) { data in
            
            guard let result = try? self.networkManager.decoder.decode(PhotoSearch.self, from: data) else { return print("decoding failed") }
            
            dump(result)
            
        }
    }
    
    /* func callRequest() {
        guard let apiKey = Bundle.main.apiKey else { return }
        print(apiKey)
        
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=1&per_page=20&order_by=latest&color=yellow&client_id=\(apiKey)"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: PhotoSearch.self) { response in
                
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
        
    } */
    
}
