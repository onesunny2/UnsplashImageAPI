//
//  PhotoTopic.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import Foundation

struct PhotoTopic: Decodable {
    let id: String
    let uploadDate: String
    let width: Int
    let height: Int
    let urls: TopicUrls
    let likes: Int
    let user: TopicUser
    
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

struct TopicUrls: Decodable {
    let raw: String
    let small: String
}

struct TopicUser: Decodable {
    let name: String
    let profile: TopicProfile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profile = "profile_image"
    }
}

struct TopicProfile: Decodable {
    let medium: String
}
