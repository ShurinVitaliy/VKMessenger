//
//  FriendPageHeaderView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageHeaderView: UIView {
    
    var topBarView: FriendPageTopBarView!
    var titleView: FriendPageTitleView!
    var buttonView: FriendPageButtonView!
    
    override func performLayout() {
        self.backgroundColor = .white
        
        topBarView = FriendPageTopBarView(topInset: 10, width: 375, height: 54)
        self.addSubview(topBarView)
        
        titleView = FriendPageTitleView(origin: topBarView.bottomLeftPoint(), width: 375, height: 115)
        self.addSubview(titleView)
        
        buttonView = FriendPageButtonView(origin: titleView.bottomLeftPoint(), width: 375, height: 40)
        self.addSubview(buttonView)
    }
}
