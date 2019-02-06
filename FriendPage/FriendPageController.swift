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
    private var scrollView: UIScrollView!
    private var stackView: UIStackView!
    
    init(friend: Friend) {
        super.init(nibName: nil, bundle: nil)
        self.friend = friend
        self.stackView = createStackView()
        self.scrollView = createScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = scrollView
        navigationItem.title = friend.first_name
        setupConstraintsStackView()
        /*
        let headerView = FriendPageHeader()
        self.view = headerView
        
        setUpTextData()
        getImage(imageURL: friend.photo_100!)
 */
    }
    
    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.lightGray
        scrollView.addSubview(stackView)

        return scrollView
    }
    
    private func createStackView() -> UIStackView {

        let friendPageHeader1 = FriendPageHeader(friend: friend)
        let friendPageHeader = FriendPageHeader(friend: friend)

        let stackView = UIStackView(arrangedSubviews: [friendPageHeader1, friendPageHeader])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }
    
    private func setupConstraintsStackView() {
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    private func getImage(imageURL: String) {
        let imageManager = ImageManager()
        imageManager.getImage(imageURL: imageURL, complete: {[weak self] (image) in
            (self?.view as? FriendPageHeader)?.userImageView.image = image
        })
    }
    
    private func setUpTextData() {
        (self.view as? FriendPageHeader)?.userLabel.text = friend.first_name! + " " + friend.last_name!
        (self.view as? FriendPageHeader)?.onlineLabel.text = (friend.online == 1 ? "online" : "ofline" )
        (self.view as? FriendPageHeader)?.regionLabel.text = "not Found"
    }
}

