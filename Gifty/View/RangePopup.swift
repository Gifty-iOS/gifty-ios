//
//  RangePopup.swift
//  Gifty
//
//  Created by jito on 8/27/23.
//

import UIKit

class RangePopup: UIView {
    private let width = 250
    private let height = 150

    init() {
        super.init(
            frame: CGRect(x: Int(Const.Screen.width / 2 - CGFloat(width / 2)),
                          y: Int(Const.Screen.height) / 2 - 90,
                          width: width,
                          height: height)
        )
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setStyle() {
        backgroundColor = .white
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        layer.cornerRadius = 8
    }
}
