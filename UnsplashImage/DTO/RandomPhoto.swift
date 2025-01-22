//
//  RandomPhoto.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/22/25.
//

import Foundation

struct RandomPhoto: Decodable {
    let id: String
    let uploadDate: String
    let width: Int
    let height: Int
    let urls: RandomUrls
    let likes: Int
    let user: RandomUser
    
    enum CodingKeys: String, CodingKey {
        case id
        case uploadDate = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}

struct RandomUrls: Decodable {
    let raw: String
    let small: String
}

struct RandomUser: Decodable {
    let name: String
    let profile: TopicProfile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profile = "profile_image"
    }
}

struct RandomProfile: Decodable {
    let medium: String
}
