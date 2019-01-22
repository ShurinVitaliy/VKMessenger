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
        guard let accesToken = VKSdk.accessToken()?.accessToken else {
            return ""
        }
        return accesToken
    }
    
    static var userId: String {
        guard let userId = VKSdk.accessToken()?.userId else {
            return ""
        }
        return userId
    }
    
    static var friendsURL: String {
        return "friends.get?user_ids=\(userId)&fields=photo_50&v=5.8&access_token=\(accessToken)"
    }
}
