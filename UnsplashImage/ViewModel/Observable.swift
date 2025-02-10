//
//  Observable.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 2/10/25.
//

import Foundation

final class Observable<T> {
    
    var closure: ((T) -> ())?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> ()) {
        closure(value)
        self.closure = closure
    }
    
    func lazyBind(_ closure: @escaping (T) -> ()) {
        self.closure = closure
    }
}
