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
    var buttonLogIn = ButtonLogIn()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        addSubview(buttonLogIn)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        buttonLogIn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonLogIn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
        buttonLogIn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonLogIn.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
}


class ButtonLogIn: UIButton {
    
    init() {
        super.init(frame: CGRect.zero)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = 18
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.4
        setTitle("LogIn", for: .normal)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (super.point(inside: point, with: event)) {
            let x = point.x
            let y = point.y
            let radius = self.layer.cornerRadius
            if(sqrt((pow(x-radius, 2) + pow(y-radius, 2))) <= radius) || (sqrt((pow(x-(self.bounds.width - radius), 2) + pow(y-radius, 2))) <= radius) || (x >= radius && x <= (self.bounds.width - radius)) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
