//
//  ViewController.swift
//  Gifty
//
//  Created by jito on 8/23/23.
//

import UIKit

class ViewController: UIViewController {
    private let searchButton = SearchButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setLayout()
    }
    
    func addSubviews() {
        view.addSubview(searchButton)
    }
    
    func setLayout() {
        
    }
}
