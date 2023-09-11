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
        super.init(frame: CGRect.zero)
        setupImage()
    }
    
    func setupAction(action: UIAction? = nil) {
        if let action = action {
            addAction(action, for: .touchUpInside)
        }
    }
    
    func setupImage() {
        setImage(UIImage(named: "search"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
