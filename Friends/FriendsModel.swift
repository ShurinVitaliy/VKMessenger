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
    func gettingImageDidComplete(indexPath: IndexPath, image: UIImage)
}

class FriendsModelImp: FriendsModel {
    
    weak var delegate: FriendsModelDelegate?
    private var friends: [Friend]?
    
    init() {
        FrendsProvider().loadFriends(completeGetFreiendsWithResult)
    }
    private func completeGetFreiendsWithResult(friendsStructureReceivedSuccessfully: [Friend]) {
        self.friends = friendsStructureReceivedSuccessfully
        delegate?.gettingFriendsDidComplete()
    }
    
    private func loadCompleteWithResult(indexPath: IndexPath, image: UIImage) {
        delegate?.gettingImageDidComplete(indexPath: indexPath, image: image)
    }
    
    func countOfFriends() -> Int {
        return friends?.count ?? 0
    }
    
    func getFriends() -> [Friend] {
        return friends ?? []
    }
    
    func getImage(indexPath: IndexPath,friend: Friend) {
        let loader = ImageLoader(imageURLString: friend.photo_50!)
        loader.getImage(indexPath: indexPath, loadCompleteWithResult: loadCompleteWithResult)
    }
}









//https://api.vk.com/method/friends.get?user_ids=182829034&fields=photo_100&v=5.8&access_token=cbd54b0bff52c4b2c2340709cbdcc59b75e2c8f71d77d0656322121686fdbb32de648d98c911b94f8f0f9 // friends

//https://api.vk.com/method/messages.getHistory?user_ids=182829034&fields=photo_100&v=5.8&access_token=cbd54b0bff52c4b2c2340709cbdcc59b75e2c8f71d77d0656322121686fdbb32de648d98c911b94f8f0f9
