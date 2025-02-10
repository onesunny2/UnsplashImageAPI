//
//  APIStatus.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/23/25.
//

import Foundation

// TODO: error protocol 찾아보기
enum APIStatus {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case networkError1
    case networkError2
    
    init?(statusCode: Int) {
        switch statusCode {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 500: self = .networkError1
        case 503: self = .networkError2
        default:
            print("statudCode error")
            return nil
        }
    }
    
    var codeNumber: Int {
        switch self {
        case .badRequest: return 400
        case .unauthorized: return 401
        case .forbidden: return 403
        case .notFound: return 404
        case .networkError1: return 500
        case .networkError2: return 503
        }
    }
    
    var alertMessage: String {
        switch self {
        case .badRequest: return "Bad Request"
        case .unauthorized: return "Unauthorized"
        case .forbidden: return "Forbidden"
        case .notFound: return "Not Found"
        case .networkError1: return "Network Error"
        case .networkError2: return "Network Error"
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
