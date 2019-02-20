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
        guard let accesToken = VKSdk.accessToken()?.accessToken else { //библиотека не предоставляет токен если на этапе логина нет интернета, ид тоже
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
        return "friends.get?user_ids=\(userId)&fields=photo_100&v=5.8&access_token=\(accessToken)"
    }
    
    static func userPhotosURL(ownerId: String) -> String {
        return "photos.getAll?owner_id=\(ownerId)&extended=1&offset=0&count=200&v=5.77&access_token=\(accessToken)"
    }
    
    static func userDialogURL(ownerId: String) -> String {
        return "messages.getHistory?user_id=\(ownerId)&count=200&offset=0&v=5.8&access_token=\(accessToken)"
    }
    
    static func sendMessage(ownerId: String, message: String) -> String {
        return "messages.send?user_id=\(ownerId)&random_id=\(Int(arc4random()))&message=\(message)&v=5.68&access_token=\(accessToken)"
    }
    
    
}
//https://api.vk.com/method/messages.getHistory?user_id=57371608&count=50&offset=0&v=5.8&access_token=559833547726ba2ab10463f8558213cae0eead25801efe6205d664883b186c55006397c4a864a55f3620c


//"https://api.vk.com/method/" + "messages.send" + "?" + "user_id" + "=\(ownerId)&" +  "random_id" + "=\(randomId)&message=\(message)&v=5.68&access_token=\(accessToken)"
