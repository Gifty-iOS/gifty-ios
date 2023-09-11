//
//  ViewController.swift
//  Gifty
//
//  Created by jito on 8/23/23.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let detectBarcodeService = DetectBarcodeService()
    private let searchButton = SearchButton()
    private let giftBoxImage = GiftBoxImage(image: UIImage(named: "GiftBox"))
    private var cancellables = Set<AnyCancellable>()
    private let rangePopup = RangePopup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        binding()
        setAction()
        addSubviews()
    }
}

// MARK: - 뷰모델 바인딩
extension MainViewController {
    private func binding() {
        viewModel.$photoCount
            .receive(on: DispatchQueue.main)
            .sink { [self] photoCount in
                rangePopup.setPhotoCount(photoCount: photoCount)
            }
            .store(in: &cancellables)
    }
}

// MARK: - 레이아웃 설정
extension MainViewController {
    private func addSubviews() {
        view.addSubview(searchButton)
        view.addSubview(giftBoxImage)
    }
}

// MARK: - 액션 설정
extension MainViewController {
    private func setAction() {
        let serchButtonAction = UIAction { [self] _ in
            Task {
                let alert = await viewModel.setPermission()
                
                guard let alert = alert else {
                    view.addSubview(rangePopup)
                    return
                }
                present(alert, animated: true, completion: nil)
            }
        }
        
        rangePopup.setupAction(
            submit: UIAction { [self] _ in
                rangePopup.removeFromSuperview()
                detectBarcodeService.detectBarcodeInImage(images: [])
            }
        )
        searchButton.setupAction(action: serchButtonAction)
    }
}
