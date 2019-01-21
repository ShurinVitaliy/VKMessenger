//
//  Constants.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/17/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import VK_ios_sdk

struct Constants {
    static let apiVk = "https://api.vk.com/method/"
    static var accessToken: String {
        //TODO: For such popuses it is better to use guard instead of if else
        if let accesToken = VKSdk.accessToken()?.accessToken {
            return accesToken
        } else {
            return ""
        }
    }
    
    static var userId: String {
        //TODO: For such popuses it is better to use guard instead of if else
        if let userId = VKSdk.accessToken()?.userId {
            return userId
        } else {
            return ""
        }
    }
    static var friendsURL: String {
        return "friends.get?user_ids=\(userId)&fields=photo_100&v=5.8&access_token=\(accessToken)"
    }
    
    
}
