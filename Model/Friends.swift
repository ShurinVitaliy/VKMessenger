//
//  Friends.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class Requests {
    func getJSONFriends() -> String {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?user_ids=\(UserDefaults.standard.object(forKey: "userId") as! String)&fields=photo_100&v=5.8&access_token=\(UserDefaults.standard.object(forKey: "accesToken") as! String)") else {
            return ""
        }
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                return
            }
            
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("json")
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        return ""
    }
    
}

struct Friend: Decodable {
    var firstName: String?
    var id: Int?
    var lastName: String?
    var online: Int?
    var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case first_name
        case id
        case last_name
        case online
        case photo_100
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try? container.decode(String.self, forKey: .first_name)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.lastName = try? container.decode(String.self, forKey: .last_name)
        self.online = try? container.decode(Int.self, forKey: .online)
        self.photo = try? container.decode(String.self, forKey: .photo_100)
    }
}
