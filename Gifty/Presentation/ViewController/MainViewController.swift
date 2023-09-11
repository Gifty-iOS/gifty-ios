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
    private let defaultLabel = DefaultLabel(text: "불러온 사진이 없어요 🥲\n돋보기를 클릭해 기프티콘을 찾을 수 있어요!", size: 14, color: UIColor(hexCode: "333333"))
    private let appLogo = AppLogo()
    private let detectBarcodeService = DetectBarcodeService()
    private let searchButton = SearchButton()
    private let rangePopup = RangePopup()
    private var cancellables = Set<AnyCancellable>()
    
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
        view.addSubview(appLogo)
        view.addSubview(defaultLabel)
        
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        defaultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appLogo.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            defaultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            defaultLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
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
        searchButton.setupAction(action: serchButtonAction)
        
        rangePopup.setupAction(
            submit: UIAction { [self] _ in
                rangePopup.removeFromSuperview()
                detectBarcodeService.detectBarcodeInImage(images: [])
            }
        )
    }
}
