//
//  SearchButton.swift
//  Gifty
//
//  Created by jito on 8/24/23.
//

import UIKit

class SearchButton: UIButton {
    private let width: CGFloat = 150
    private let height: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: CGRect(x: Const.Screen.width / 2 - width / 2, y: Const.Screen.height / 2, width: width, height: height))
        setupGradient(view: self)
        setupStyle()
        setupText()
    }
    
    func setupAction(action: UIAction? = nil) {
        if let action = action {
            addAction(action, for: .touchUpInside)
        }
    }
    
    func setupText() {
        setTitle("기프티콘 찾기!", for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel?.textColor = .white
    }
    
    func setupStyle() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    func setupGradient(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.init(hexCode: Const.Color.gradientFirst),
            UIColor.init(hexCode: Const.Color.gradientSecond),
            UIColor.init(hexCode: Const.Color.gradientThird),
        ].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 0.5, 1]
        
        view.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
