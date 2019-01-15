//
//  FriendsRequests.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class Requests {
    
    func getJSONFriends(_ complete: @escaping(_ friendListResponse: FriendListResponse) -> Void) {
        let urlString: String = "https://api.vk.com/method/friends.get?user_ids=\(UserDefaults.standard.object(forKey: "userId") as! String)&fields=photo_100&v=5.8&access_token=\(UserDefaults.standard.object(forKey: "accesToken") as! String)"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                var friends = try JSONDecoder().decode(FriendListResponse.self, from: data!)
                DispatchQueue.main.async {
                    
                }
                complete(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}

struct FriendListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response
    }
    var response : FriendListResponseItems
}

struct FriendListResponseItems: Decodable {
    enum CodingKeys: String, CodingKey {
        case items
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try? container.decode(Int.self, forKey: .count)
        self.items = try? container.decode([Friend].self, forKey: .items)
    }
    
    var count: Int?
    var items: [Friend]?
}

struct Friend: Decodable {
    var first_name: String?
    var id: Int?
    var last_name: String?
    var online: Int?
    var photo_100: String?
    
    enum CodingKeys: String, CodingKey {
        case first_name
        case id
        case last_name
        case online
        case photo_100
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try? container.decode(String.self, forKey: .first_name)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.last_name = try? container.decode(String.self, forKey: .last_name)
        self.online = try? container.decode(Int.self, forKey: .online)
        self.photo_100 = try? container.decode(String.self, forKey: .photo_100)
    }
}
