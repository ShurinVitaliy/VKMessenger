//
//  FriendsRequests.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class FrendsProvider {
    
    static func loadFriends(_ completionHandler: @escaping(_ friendListResponse: [FriendImp]?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.friendsURL
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
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
    var items: [FriendImp]?
}

struct FriendImp: Decodable, Friend {
    var first_name: String
    var id: Int
    var last_name: String
    var online: Int
    var photo_100: String
}
