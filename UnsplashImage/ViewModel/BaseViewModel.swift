//
//  BaseViewModel.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 2/10/25.
//

import Foundation

protocol BaseViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transformBinds()
}
