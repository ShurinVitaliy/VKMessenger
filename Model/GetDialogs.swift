//
//  GetDialogs.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import VK_ios_sdk

class GetDailogs {
    private(set) var countOfMessage: Int!
    private(set) var countOfSet: Int!
    var accesToken: String {
        return UserDefaults.standard.object(forKey: "accesToken") as? String ?? ""
    }
    var userId: String {
        return UserDefaults.standard.object(forKey: "userId") as? String ?? ""
    }
    
    private let kBaseURl: String = "https://api.vk.com/method/"
    private let kATK: String = "&access_token="
    private let kvV: String = "&v=5.92"
    
    //https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate & access_token= 533bacf01e11f55b536a565b57531ac114461ae8736d6506a3 &v=5.92
    init(countOfMessage: Int, countOfSet: Int) {
        self.countOfMessage = countOfMessage
        self.countOfSet = countOfSet
    }
    
    init() {
        self.countOfMessage = 0
        self.countOfSet = 0
    }
    
    func getFriends() {
        let urlString: String = "\(kBaseURl)friends.get?user_id=\(userId)"
        let myUrl = URL(string: urlString)!
        let request = URLRequest(url: myUrl)
        print("my request")
        
        print(request)
    }
}
