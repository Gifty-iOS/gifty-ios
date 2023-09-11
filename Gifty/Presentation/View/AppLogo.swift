//
//  AppLogo.swift
//  Gifty
//
//  Created by 주동석 on 2023/09/11.
//

import UIKit

class AppLogo: UIView {
    private let logoImageView = UIImageView()
    private let logoTitle = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        logoImageView.image = UIImage(named: "GiftyIcon")
        logoTitle.text = "gifty"
        
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        addSubview(logoImageView)
        addSubview(logoTitle)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 35),
            logoImageView.heightAnchor.constraint(equalToConstant: 26),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            
            logoTitle.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            logoTitle.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 2),
        ])
    }
    
    func setStyle() {
        logoTitle.font = Fonts.nanumSquareEB(size: 18)
    }
}
