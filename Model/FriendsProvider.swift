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
    
    func getStructOfFriends(_ gettingFriendsSuccessfully: @escaping(_ friendListResponse: FriendList) -> Void) {
        let urlString: String = Constants.apiVk + Constants.friendsURL
        let url = URL(string: urlString)
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

struct FriendList: Decodable {
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

struct Photo {
    var image: [UIImage] = []
    var index: [Int] = []
    init(image: UIImage, index: Int) {
        self.image.append(image)
        self.index.append(index)
    }
}

struct Friend: Decodable {
    var first_name: String?
    var id: Int?
    var last_name: String?
    var online: Int?
    var photo_50_URL: String?
    
    enum CodingKeys: String, CodingKey {
        case first_name
        case id
        case last_name
        case online
        case photo_50
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try? container.decode(String.self, forKey: .first_name)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.last_name = try? container.decode(String.self, forKey: .last_name)
        self.online = try? container.decode(Int.self, forKey: .online)
        self.photo_50_URL = try? container.decode(String.self, forKey: .photo_50)
    }
}










/*
 var photoImageView: UIImage? {
 let url = URL(string: photo_100!)
 if let data = try? Data(contentsOf: url!) {
 return UIImage(data: data)
 } else {
 return #imageLiteral(resourceName: "defaultImage.png")
 }
 }*/
