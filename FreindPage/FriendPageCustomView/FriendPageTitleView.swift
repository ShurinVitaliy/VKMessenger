//
//  FriendPageHederView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageTitleView: UIView {
    var userImageView: UIImageView!
    var infoImageView: UIImageView!
    var userLabel: UILabel!
    var onlineLabel: UILabel!
    var regionLabel: UILabel!
    
    override func performLayout() {
        self.backgroundColor = .white
        
        userImageView = UIImageView(topInset: 15, leftInset: 10, height: 100, keepEqual: true)
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
        
        userImageView.image = #imageLiteral(resourceName: "defaultImage")
        
        self.addSubview(userImageView)
        
        infoImageView = UIImageView(topInset: 45, leftInset: 330, width: 20,keepEqual: true)
        infoImageView.image = #imageLiteral(resourceName: "defaultImage")
        infoImageView.contentMode = .scaleAspectFit
        infoImageView.clipsToBounds = true
        self.addSubview(infoImageView)
        
        userLabel = UILabel(topInset: 15, leftInset: 120, width: 284, height: 30)
        userLabel.font = UIFont.systemFont(ofSize: 30.scaleForScreenWidth())
        
        userLabel.text = "Shurin Vitaliy"
        
        self.addSubview(userLabel)
        
        onlineLabel = UILabel(topInset: 50, leftInset: 120, width: 94, height: 15)
        onlineLabel.font = UIFont.systemFont(ofSize: 15.scaleForScreenWidth())
        
        onlineLabel.text = "Online"
        
        self.addSubview(onlineLabel)
        
        regionLabel = UILabel(topInset: 70, leftInset: 120, width: 94, height: 15)
        regionLabel.font = UIFont.systemFont(ofSize: 15.scaleForScreenWidth())
        
        regionLabel.text = "Pryzhany"
        
        self.addSubview(regionLabel)
        
    }
    
}
