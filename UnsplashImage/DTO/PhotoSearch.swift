//
//  PhotoSearch.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/17/25.
//

import Foundation

/*
 검색결과가 없을 때를 대비해서 VC에서 반환값 받게 해보자
 */

struct PhotoSearch: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let uploadDate: String
    let width: Int
    let height: Int
    let urls: Urls
    let likes: Int
    let user: User
    
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

struct Urls: Decodable {
    let raw: String
    let small: String
}

struct User: Decodable {
    let name: String
    let profile: Profile
    
    enum CodingKeys: String, CodingKey {
        case name
        case profile = "profile_image"
    }
}

struct Profile: Decodable {
    let medium: String
}


/*
 id: String
 create_at: String
 width: Int
 height: Int
 urls: photoUrl
 > raw: String
 > small: String
 likes: Int
 user: User
 > name: String
 profile_image: Profile
     > medium: String
 
 */
