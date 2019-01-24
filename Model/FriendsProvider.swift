//
//  FriendsRequests.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FrendsProvider {
    
    static func loadFriends(_ completionHandler: @escaping(_ friendListResponse: [Friend]?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.friendsURL
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in //общая сессия
            do {
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                let friends = try JSONDecoder().decode(FriendList.self, from: data)
                completionHandler(friends.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
}

private struct FriendList: Decodable {
    var response : FriendListResponseItems
}

private struct FriendListResponseItems: Decodable {
    var count: Int?
    var items: [Friend]?
}

struct Friend: Decodable {
    var first_name: String?
    var id: Int?
    var last_name: String?
    var online: Int?
    var photo_50: String?
}



//https://api.vk.com/method/friends.get?user_ids=182829034&fields=photo_100&v=5.8&access_token=cbd54b0bff52c4b2c2340709cbdcc59b75e2c8f71d77d0656322121686fdbb32de648d98c911b94f8f0f9 // friends






