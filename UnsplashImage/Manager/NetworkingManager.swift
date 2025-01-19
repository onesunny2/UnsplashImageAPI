//
//  NetworkingManager.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit
import Alamofire

class NetworkingManager {
    
    static let shared = NetworkingManager()
    let decoder = JSONDecoder()
    private init() {}
    
    func callRequest(url: String, completionHandler: @escaping (Data) -> ()) {
        
        AF.request(url, method: .get).responseString { value in
//            print(value)
        }
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<500)
            .responseData(completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        completionHandler(data)
                    case .failure(let error):
                        print("error", error)
                    }

            })
    }
}

