//
//  TopicDetailViewController.swift
//  UnsplashImage
//
//  Created by Lee Wonsun on 1/20/25.
//

import UIKit
import SnapKit

final class TopicDetailViewController: UIViewController {
    
    private let mainView: BaseDetailView
    let viewModel = DetailViewModel()
    
    private var ratio: CGFloat
    
    init(ratio: CGFloat) {
        self.ratio = ratio
        self.mainView = BaseDetailView(ratio: ratio)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configView()
        bindVMData()
        
        viewModel.input.callRequest.value = ()
    }
    
    deinit {
        print("토픽 VC Deinit")
    }
    
    private func bindVMData() {
        viewModel.output.countText.bind { [weak self] text in
            self?.mainView.viewCountDatailLabel.text = text
        }
        
        viewModel.output.downloadText.bind { [weak self] text in
            self?.mainView.downloadDetailLabel.text = text
        }
        
        viewModel.output.statusCode.lazyBind { code in
            
            guard let code else { return }
            
            self.alertMessage(code: code.codeNumber, message: code.alertMessage)
        }
    }
    
    private func configView() {
        
        guard let data = viewModel.data else {
            
            mainView.getImageUrl(user: viewModel.defaultImage, thum: viewModel.defaultImage)
            
            return
        }

        let width = data.width.formatted()
        let height = data.height.formatted()
        
        mainView.getImageUrl(user: data.user.profile.medium, thum: data.urls.small)
        mainView.userNameLabel.text = data.user.name
        mainView.uploadDateLabel.text = data.uploadDate.changeDate()
        mainView.sizeDetailLabel.text = width + " x " + height
    }

//    func getInfoFromGeneric() {
//        networkingManager.callRequestByGeneric(type: Statistics.self, api: .statistics(userId: photoTopic.id)) { result in
//            
//            self.mainView.viewCountDatailLabel.text = String(result.views.total.formatted())
//            self.mainView.downloadDetailLabel.text = String(result.downloads.total.formatted())
// 
//        } failHandler: { statusCode in
//            print("호출 실패했습니다")
//            self.alertMessage(code: statusCode.codeNumber, message: statusCode.alertMessage)
//        }
//
//    }

}
