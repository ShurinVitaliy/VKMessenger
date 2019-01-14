//
//  FriendsModel.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

protocol FriendsModel {
    
}

class FriendsModelImp: FriendsModel {
    var friendsController: FriendsController!
    init(friendsController: FriendsController) {
        self.friendsController = friendsController
    }
}
