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
        let serchButtonAction = UIAction { [self] _ in
            let customPopup = RangePopup()
            self.view.addSubview(customPopup)
        }
        searchButton.setupAction(action: serchButtonAction)
        view.addSubview(searchButton)
        view.addSubview(giftBoxImage)
    }
    
    private func setLayout() {
        
    }
}
