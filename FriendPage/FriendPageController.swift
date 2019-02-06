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
    
    //TODO: It should be designed init not convinience. Explain me the difference
    //нет необходимости в спомогательном инициализаторе
    init(friend: Friend) {
        super.init(nibName: nil, bundle: nil)
        self.friend = friend
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let headerView = FriendPageHeader()
        self.view = headerView
        navigationItem.title = friend.first_name
        setUpTextData()
        getImage(imageURL: friend.photo_100!)
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

