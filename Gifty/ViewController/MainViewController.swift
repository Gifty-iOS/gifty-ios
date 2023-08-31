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
            photoLibraryService.requestPermission { [self] status in
                if (!status) {
                    let requestAlert = photoLibraryService.createPhotoLibraryRequestAlert()
                    present(requestAlert, animated: true, completion: nil)
                    return
                }
                
                let photoCount = photoLibraryService.getPhotoCount()
                let rangePopup = RangePopup(maxLen: photoCount)
                
                rangePopup.setupAction(
                    submit: UIAction { [self] _ in
                        rangePopup.removeFromSuperview()
                        detectBarcodeService.detectBarcodeInImage(images: [])
                    }
                )
                view.addSubview(rangePopup)
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
