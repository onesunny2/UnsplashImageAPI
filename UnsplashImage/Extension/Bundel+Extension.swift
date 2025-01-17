//
//  Bundel+Extension.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["APIKey"] as? String
    }
}
