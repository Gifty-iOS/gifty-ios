//
//  GiftBoxImage.swift
//  Gifty
//
//  Created by jito on 8/24/23.
//

import UIKit

class GiftBoxImage: UIImageView {
    private let width: CGFloat = 160
    private let height: CGFloat = 160
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.frame = CGRect(x: Const.Screen.width / 2 - width / 2, y: Const.Screen.height / 2 - 180, width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
