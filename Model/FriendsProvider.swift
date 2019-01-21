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
    
    //TODO: name should be func loadFriends(_ completionHandler: @escaping(_ friendListResponse: FriendList) -> Void).
    //TODO: (_ friendListResponse: FriendList) should be (_ friendListResponse: [Friend]])
    func getStructOfFriends(_ gettingFriendsSuccessfully: @escaping(_ friendListResponse: FriendList) -> Void) {
        let urlString: String = Constants.apiVk + Constants.friendsURL
        let url = URL(string: urlString)
        //TODO: Do not use forceunwrap. Use guard instead
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let friends = try JSONDecoder().decode(FriendList.self, from: data!)
                gettingFriendsSuccessfully(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}

//TODO: This is a private struct needed you only for parsing
struct FriendList: Decodable {
    //TODO: It is not needed to define CodingKeys enum in case if property name is the same as coding key response == response
    enum CodingKeys: String, CodingKey {
        case response
    }
    var response : FriendListResponseItems
}
//TODO: This is a private struct needed you only for parsing
struct FriendListResponseItems: Decodable {
    //TODO: It is not needed to define CodingKeys enum in case if property name is the same as coding key response == response
    enum CodingKeys: String, CodingKey {
        case items
        case count
    }
    
    //TODO: It is not needed to override init
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
    
    //TODO: Should be replaced with image loader logic
    var photoImageView: UIImage? {
        let url = URL(string: photo_100!)
        if let data = try? Data(contentsOf: url!) {
            return UIImage(data: data)
        } else {
            return #imageLiteral(resourceName: "defaultImage.png")
        }
    }
    //TODO: It is not needed to define CodingKeys enum in case if property name is the same as coding key response == response
    enum CodingKeys: String, CodingKey {
        case first_name
        case id
        case last_name
        case online
        case photo_100
    }
    
    //TODO: It is not needed to override init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try? container.decode(String.self, forKey: .first_name)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.last_name = try? container.decode(String.self, forKey: .last_name)
        self.online = try? container.decode(Int.self, forKey: .online)
        self.photo_100 = try? container.decode(String.self, forKey: .photo_100)
        
    }
}










