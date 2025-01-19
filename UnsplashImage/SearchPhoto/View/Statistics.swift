//
//  Statistics.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import Foundation

struct Statistics: Decodable {
    let id: String
    let downloads: Downloads
    let views: Views
}

struct Downloads: Decodable {
    let total: Int
    let historical: DownloadHistorical
}

struct DownloadHistorical: Decodable {
    let values: [DownloadValues]
}

struct DownloadValues: Decodable {
    let date: String
    let value: Int
}

struct Views: Decodable {
    let total: Int
    let historical: ViewsHistorical
}

struct ViewsHistorical: Decodable {
    let values: [ViewsValues]
}

struct ViewsValues: Decodable {
    let date: String
    let value: Int
}
