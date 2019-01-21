//
//  FriendsModel.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

protocol FriendsModel {
    func countOfFriends() -> Int
    func getFriends() -> [Friend]
    var delegate: FriendsModelDelegate? {get set}
    func getImage(indexPath: IndexPath,friend: Friend)
}

protocol FriendsModelDelegate: class {
    func gettingFriendsDidComplete()
    func gettingImageOfSpecificFriendDidComplete(indexPath: IndexPath, image: UIImage)
}

class FriendsModelImp: FriendsModel {
    
    weak var delegate: FriendsModelDelegate?
    var friendsController: FriendsController!
    var friendsResponse: FriendList?
    
    init(friendsController: FriendsController) {
        self.friendsController = friendsController
        FrendsProvider().getStructOfFriends(completeGetFreiendsWithResult)
    }
    func completeGetFreiendsWithResult(friendsStructureReceivedSuccessfully: FriendList) {
        self.friendsResponse = friendsStructureReceivedSuccessfully
        delegate?.gettingFriendsDidComplete()
    }
    
    func countOfFriends() -> Int {
        return friendsResponse?.response.count ?? 0
    }
    
    func getFriends() -> [Friend] {
        return (friendsResponse?.response.items)!
    }
    
    func loadCompleteWithResult(indexPath: IndexPath, image: UIImage) {
        delegate?.gettingImageOfSpecificFriendDidComplete(indexPath: indexPath, image: image)
    }
    
    func getImage(indexPath: IndexPath,friend: Friend) {
        let loader = ImageLoader(imageURLString: friend.photo_50_URL!)
        loader.getImage(indexPath: indexPath, loadCompleteWithResult: loadCompleteWithResult)
    }
}









//https://api.vk.com/method/friends.get?user_ids=182829034&fields=photo_100&v=5.8&access_token=cbd54b0bff52c4b2c2340709cbdcc59b75e2c8f71d77d0656322121686fdbb32de648d98c911b94f8f0f9 // friends

//https://api.vk.com/method/messages.getHistory?user_ids=182829034&fields=photo_100&v=5.8&access_token=cbd54b0bff52c4b2c2340709cbdcc59b75e2c8f71d77d0656322121686fdbb32de648d98c911b94f8f0f9
