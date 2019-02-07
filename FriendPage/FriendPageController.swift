//
//  FriendPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/5/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageController: UIViewController {
    private var friend: Friend!
    
    init(friend: Friend) {
        super.init(nibName: nil, bundle: nil)
        self.friend = friend
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let scrollView = FriendPageScrollView(friend: friend)
        (scrollView.stackView.arrangedSubviews.first as? FriendPageHeader)?.addToFreindsButton.addTarget(self, action: #selector(touch), for: .touchUpInside)
        self.view = scrollView
        navigationItem.title = friend.first_name
    }
    
    @objc private func touch(_ sender: UIButton) {
        print("dsdsdd")
    }
}

