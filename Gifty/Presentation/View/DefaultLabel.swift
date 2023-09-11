//
//  DefaultLabel.swift
//  Gifty
//
//  Created by 주동석 on 2023/09/11.
//

import UIKit

class DefaultLabel: UILabel {
    init(text: String, size: CGFloat, color: UIColor) {
        super.init(frame: CGRect.zero)
        
        self.textAlignment = .center
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = size * 1.4
        paragraphStyle.maximumLineHeight = size * 1.4
        self.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
            ]
        )
        
        self.font = Fonts.nanumSquareR(size: size)
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
