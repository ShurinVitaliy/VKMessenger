//
//  FrienPageButtonView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageButtonView: UIView {
    var sendMessageButton: UIButton!
    var buttonAddToFreinds: UIButton!
    
    override func performLayout() {
        self.backgroundColor = .white
        
        sendMessageButton = UIButton(topInset: 15, leftInset: 15, width: 165, height: 35)
        sendMessageButton.setTitle("Message", for: .normal)
        sendMessageButton.backgroundColor = .blue
        sendMessageButton.tintColor = .darkText
        sendMessageButton.layer.cornerRadius = sendMessageButton.frame.height / 2
        self.addSubview(sendMessageButton)
        
        buttonAddToFreinds = UIButton(topInset: 15, leftInset: 195, width: 165, height: 35)
        buttonAddToFreinds.setTitle("Friends", for: .normal)
        buttonAddToFreinds.backgroundColor = .blue
        buttonAddToFreinds.tintColor = .darkText
        buttonAddToFreinds.layer.cornerRadius = buttonAddToFreinds.frame.height / 2
        self.addSubview(buttonAddToFreinds)
    }
}
