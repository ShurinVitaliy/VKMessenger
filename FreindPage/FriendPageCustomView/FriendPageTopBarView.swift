//
//  FriendPageTopBarView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageTopBarView: UIView {
    var ellipsesImageView: UIImageView!
    var backImageView: UIImageView!
    var nameLabel: UILabel!
    
    override func performLayout() {
        
        self.backgroundColor = .white
        
        nameLabel = UILabel(topInset: 20, leftInset: 52, width: 284, height: 32)
        nameLabel.font = UIFont.systemFont(ofSize: 15.scaleForScreenWidth())
        nameLabel.textAlignment = .center
        nameLabel.text = "Vitaliy"
        self.addSubview(nameLabel)
        
        ellipsesImageView = UIImageView(topInset: 20, leftInset: 346, height: 32, keepEqual: true)
        ellipsesImageView.image = #imageLiteral(resourceName: "Ellipses")
        ellipsesImageView.contentMode = .scaleAspectFit
        ellipsesImageView.clipsToBounds = true
        self.addSubview(ellipsesImageView)
        
        backImageView = UIImageView(topInset: 20, leftInset: 10, height: 32, keepEqual: true)
        backImageView.image = #imageLiteral(resourceName: "download")
        backImageView.contentMode = .scaleAspectFit
        backImageView.clipsToBounds = true
        self.addSubview(backImageView)
        
    }
    
    
}
