//
//  DetailViewModel.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 2/10/25.
//

import Foundation

final class DetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        input = Input()
        output = Output()
        
        transformBinds()
    }
    
    func transformBinds() {
        
    }

}
