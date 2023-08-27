//
//  ViewController.swift
//  Gifty
//
//  Created by jito on 8/23/23.
//

import UIKit

class ViewController: UIViewController {
    private let detectBarcodeService = DetectBarcodeService()
    private let searchButton = SearchButton()
    private let giftBoxImage = GiftBoxImage(image: UIImage(named: "GiftBox"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setLayout()
    }
    
    private func addSubviews() {
        let customAction = UIAction { _ in
            self.detectBarcodeService.detectBarcodeInImage(images: [
                UIImage(named: "1")!,
                UIImage(named: "2")!,
                UIImage(named: "3")!,
            ])
        }
        searchButton.setupAction(action: customAction)
        view.addSubview(searchButton)
        view.addSubview(giftBoxImage)
    }
    
    private func setLayout() {
        
    }
}
