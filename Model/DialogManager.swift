//
//  DialogManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/20/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class DialogManager {
    
    static func sendMessage(userId: String, message: String, _ completionHandler: @escaping(_ successfully: Bool) -> Void) {
        let urlString: NSString = Constants.apiVk + Constants.sendMessage(ownerId: userId, message: message) as NSString
        let urlStr: NSString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! as NSString
        if let url = URL(string: urlStr as String) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                completionHandler(true)
            }.resume()
        } else {
            completionHandler(false)
        }
    }
}
