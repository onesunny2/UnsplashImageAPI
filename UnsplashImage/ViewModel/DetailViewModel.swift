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

    private let network = NetworkingManager.shared
    var data: PhotoResult?
    let defaultImage: String = "https://i.pinimg.com/236x/28/36/48/283648f08aad7ef71f1f0baecc333017.jpg"
    
    struct Input {
        let callRequest: Observable<Void> = Observable(())
    }
    
    struct Output {
        let countText: Observable<String> = Observable("")
        let downloadText: Observable<String> = Observable("")
        let sizeText: Observable<String> = Observable("")
        var statusCode: Observable<APIStatus?> = Observable(nil)
    }
    
    init() {
        print("디테일 VM Init")
        
        input = Input()
        output = Output()
        
        transformBinds()
    }
    
    deinit {
        print("디테일 VM Deinit")
    }
    
    func transformBinds() {
        input.callRequest.lazyBind { [weak self] _ in
            self?.callRequest()
        }
    }
 
    private func callRequest() {
        
        network.callRequestByGeneric(type: Statistics.self, api: .statistics(userId: self.data?.id ?? "")) { [weak self] result in
            
            let viewTotal = String(result.views.total.formatted())
            let downTotal = String(result.downloads.total.formatted())
            
            self?.output.countText.value = viewTotal
            self?.output.downloadText.value = downTotal
        } failHandler: { [weak self] statusCode in
            self?.output.statusCode.value = statusCode
        }
    }
}
