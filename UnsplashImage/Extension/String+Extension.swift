//
//  String+Extension.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/19/25.
//

import UIKit

extension String {
    
    static let isoDateformatter = ISO8601DateFormatter()
    static let dateformatter = DateFormatter()
    
    func changeDate() -> String {
        
        guard let date = String.isoDateformatter.date(from: self) else { return "" }
        String.dateformatter.dateFormat = "yyyy년 M월 d일 게시됨"
        
        let newDate = String.dateformatter.string(from: date)
        
        return newDate
    }
}
