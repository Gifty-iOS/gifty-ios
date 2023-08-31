//
//  ViewController.swift
//  Gifty
//
//  Created by jito on 8/23/23.
//

import UIKit
import Jito

class ViewController: UIViewController {
    private let photoLibraryService = PhotoLibraryService()
    private let detectBarcodeService = DetectBarcodeService()
    private let searchButton = SearchButton()
    private let giftBoxImage = GiftBoxImage(image: UIImage(named: "GiftBox"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAction()
        addSubviews()
        setLayout()
    }
    
    private func setAction() {
        let serchButtonAction = UIAction { [self] _ in
            photoLibraryService.requestPermission { status in
                if (!status) {
                    print("전체 권한을 허용해주세요.")
                    return
                }
                
                let photoCount = self.photoLibraryService.getPhotoCount()
                let rangePopup = RangePopup(maxLen: photoCount)
                
                rangePopup.setupAction(
                    submit: UIAction { _ in
                        rangePopup.removeFromSuperview()
                        self.detectBarcodeService.detectBarcodeInImage(images: [])
                    }
                )
                self.view.addSubview(rangePopup)
            }
        }
        searchButton.setupAction(action: serchButtonAction)
    }
    
    private func addSubviews() {
        view.addSubview(searchButton)
        view.addSubview(giftBoxImage)
    }
    
    private func setLayout() {
        
    }
}
