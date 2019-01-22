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
    
    func loadFriends(_ completionHandler: @escaping(_ friendListResponse: [Friend]) -> Void) {
        let urlString: String = Constants.apiVk + Constants.friendsURL
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                guard let data = data else {
                    return
                }
                let friends = try JSONDecoder().decode(FriendList.self, from: data)
                completionHandler(friends.response.items ?? [])
            } catch {
                print(error)
            }
            }.resume()
    }
}

//TODO: This is a private struct needed you only for parsing
private struct FriendList: Decodable {
    var response : FriendListResponseItems
}
//TODO: This is a private struct needed you only for parsing
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










