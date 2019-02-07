//
//  FriendPageScrollView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/7/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageScrollView: UIScrollView {
    private var friend: Friend!
    var stackView: UIStackView!
    
    init(friend: Friend) {
        super.init(frame: CGRect.zero)
        self.friend = friend
        self.stackView = createStackView()
        backgroundColor = UIColor.lightGray
        addSubview(stackView)
        setupConstraintsStackView()
    }
    
    private func createStackView() -> UIStackView {
        let friendPageHeader = FriendPageHeader(friend: friend)
        let stackView = UIStackView(arrangedSubviews: [friendPageHeader])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }
    
    private func setupConstraintsStackView() {
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
