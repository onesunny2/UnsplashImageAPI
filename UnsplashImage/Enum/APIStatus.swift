//
//  APIStatus.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/23/25.
//

import Foundation

enum APIStatus {
    case ok(message: String)
    case badRequest(message: String)
    case unauthorized(message: String)
    case forbidden(message: String)
    case notFound(message: String)
    case networkError(message: String)
    
    init?(statusCode: Int) {
        switch statusCode {
        case 200: self = .ok(message: "OK")
        case 400: self = .badRequest(message: "Bad Request")
        case 401: self = .unauthorized(message: "Unauthorized")
        case 403: self = .forbidden(message: "Forbidden")
        case 404: self = .notFound(message: "Not Found")
        case 500, 503: self = .networkError(message: "Network Error")
        default:
            print("statudCode error")
            return nil
        }
    }
}
