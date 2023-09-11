//
//  RangePopup.swift
//  Gifty
//
//  Created by jito on 8/27/23.
//

import UIKit

class RangePopup: UIButton {
    private let width = 250
    private let height = 165

    private let backgroundView = UIView()
    
    private let submitButton = UIButton()
    private let cancelButton = UIButton()
    
    private let minInput = UITextField()
    private let maxInput = UITextField()
    
    private let waveText = UILabel()
    
    private let title = UILabel()
    
    var maxLen: Int = 0
    
    init(maxLen: Int = 0) {
        super.init(frame: CGRect(x: 0, y: 0, width: Const.Screen.width, height: Const.Screen.height))
                
        self.addAction(UIAction { _ in
            self.removeFromSuperview()
        }, for: .touchUpInside)
        
        self.maxLen = maxLen
        
        addSubview()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        addSubview(backgroundView)
        backgroundView.addSubview(submitButton)
        backgroundView.addSubview(cancelButton)
        backgroundView.addSubview(minInput)
        backgroundView.addSubview(maxInput)
        backgroundView.addSubview(waveText)
        backgroundView.addSubview(title)
    }
    
    private func setLayout() {
        backgroundView.frame = CGRect(x: Int(Const.Screen.width / 2 - CGFloat(width / 2)),
                                             y: Int(Const.Screen.height) / 2 - 90,
                                             width: width,
                                             height: height)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -25).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: CGFloat(width - 50)).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        minInput.translatesAutoresizingMaskIntoConstraints = false
        minInput.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 60).isActive = true
        minInput.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
        minInput.widthAnchor.constraint(equalToConstant: CGFloat(width / 2) - 40).isActive = true
        minInput.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        maxInput.translatesAutoresizingMaskIntoConstraints = false
        maxInput.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 60).isActive = true
        maxInput.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
        maxInput.widthAnchor.constraint(equalToConstant: CGFloat(width / 2) - 40).isActive = true
        maxInput.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        waveText.translatesAutoresizingMaskIntoConstraints = false
        waveText.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 60).isActive = true
        waveText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
        title.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 25).isActive = true
    }
    
    private func setStyle() {
        backgroundView.backgroundColor = .white
        backgroundView.layer.shadowColor = UIColor.gray.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowRadius = 4
        backgroundView.layer.shadowOpacity = 0.3
        backgroundView.layer.cornerRadius = 8
        
        submitButton.backgroundColor = UIColor.init(hexCode: "#0073cf")
        submitButton.layer.cornerRadius = 8
        submitButton.setTitle("확인", for: .normal)
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.masksToBounds = true
        
        cancelButton.backgroundColor = .lightGray
        cancelButton.layer.cornerRadius = 8
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cancelButton.setTitleColor(.white, for: .normal)
        
        minInput.placeholder = "0"
        minInput.layer.borderColor = UIColor.lightGray.cgColor
        minInput.layer.borderWidth = 1
        minInput.keyboardType = .numberPad
        minInput.layer.cornerRadius = 8
        minInput.font = UIFont.systemFont(ofSize: 14)
        minInput.addLeftPadding()
        
        maxInput.placeholder = maxLen.description
        maxInput.layer.borderColor = UIColor.lightGray.cgColor
        maxInput.layer.borderWidth = 1
        maxInput.keyboardType = .numberPad
        maxInput.layer.cornerRadius = 8
        maxInput.font = UIFont.systemFont(ofSize: 14)
        maxInput.addLeftPadding()
        
        waveText.text = "~"
        waveText.font = UIFont.boldSystemFont(ofSize: 20)
        
        title.text = "검색할 사진 범위를 입력해주세요."
        title.textColor = UIColor(hexCode: "333333")
        title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func setupAction(submit: UIAction? = nil) {
        if let submit = submit {
            submitButton.addAction(submit, for: .touchUpInside)
        }
    }
    
    func setPhotoCount(photoCount: Int) {
        self.maxLen = photoCount
        maxInput.placeholder = maxLen.description
    }
}
