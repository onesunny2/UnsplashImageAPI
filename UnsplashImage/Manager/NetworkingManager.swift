//
//  NetworkingManager.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import UIKit
import Alamofire

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    let decoder = JSONDecoder()
    
    private init() {}
    
    func callRequest(api: UnsplashAPI, completionHandler: @escaping (Data) -> ()) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.queryParameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header).responseString { value in
//            print(value)
        }

        AF.request(api.endPoint,
                   method: .get,
                   parameters: api.queryParameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .validate(statusCode: 200..<500)
            .responseData(completionHandler: { response in
//                debugPrint(response)
                    switch response.result {
                    case .success(let data):
                        completionHandler(data)
                    case .failure(let error):
                        print("error", error)
                    }

            })
    }
    
    func callRequestByGeneric<T: Decodable>(type: T.Type, api: UnsplashAPI, completeHandler: @escaping (T) -> (), failHandler: @escaping () -> (), statusHandler: @escaping (Int) -> ()) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.queryParameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header
        ).responseString { value in
//            print(value)
        }
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.queryParameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header
        ).responseDecodable(of: T.self) { response in
//            debugPrint(response)
            guard let statusCode = response.response?.statusCode else { return }
            statusHandler(statusCode)
            
            switch response.result {
            case let .success(value):
                completeHandler(value)
            case let .failure(error):
                print("매니저 에러", error)
                failHandler()
            }
        }
    }
}

extension NetworkingManager {
    
    enum UnsplashAPI {
        case search(query: String, page: Int, sort: String, color: String)
        case topic(topic: String)
        case statistics(userId: String)
        case random
        
        var header: HTTPHeaders {
            guard let apiKey = Bundle.main.apiKey else { return HTTPHeaders()}
            return ["Authorization": "Client-ID \(apiKey)"]
        }
        
        var method: HTTPMethod {
            return .get
        }
        
        var baseURL: String {
            return "https://api.unsplash.com/"
        }
        
        var endPoint: String {
            switch self {
            case .search: 
                return baseURL + "search/photos"
            case let .topic(topic): 
                return baseURL + "topics/\(topic)/photos"
            case let .statistics(userId): 
                return baseURL + "photos/\(userId)/statistics"
            case .random: 
                return baseURL + "photos/random"
            }
        }
        
        var queryParameter: Parameters {
            switch self {
            case let .search(query, page, sort, color):
                return ["query": query, "page": page, "order_by": sort, "color": color]
            case .topic:
                return ["page": 1]
            case .statistics:
                return [:]
            case .random:
                return ["count": 10]
            }
        }
    }
}
