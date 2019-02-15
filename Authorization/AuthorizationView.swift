//
//  AuthorizationView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/15/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationView: UIView {
    var buttonLogIn: UIButton!
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        buttonLogIn = setupButton(title: "Log In")
        addSubview(buttonLogIn)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) -> UIButton{
        let button = UIButton(type: .roundedRect)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 18
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowOpacity = 0.4
        
        return button
    }
    
    private func setupConstraints() {
        
        buttonLogIn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonLogIn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
        buttonLogIn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonLogIn.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
}
