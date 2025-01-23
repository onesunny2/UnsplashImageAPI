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
        case 200: self = .ok(message: "Connec Success")
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
    
    var alertMessage: String {
        switch self {
        case .ok(let message): message
        case .badRequest(let message): message
        case .unauthorized(let message): message
        case .forbidden(let message): message
        case .notFound(let message): message
        case .networkError(let message): message
        }
    }
}

/*
 200 - OK    Everything worked as expected
 400 - Bad Request    The request was unacceptable, often due to missing a required parameter
 401 - Unauthorized    Invalid Access Token
 403 - Forbidden    Missing permissions to perform request
 404 - Not Found    The requested resource doesn’t exist
 500, 503    Something went wrong on our end
 */
