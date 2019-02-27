//
//  DialogPageProvider.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/18/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class DialogPageProvider {
    
    static func sendMessage(userId: String, message: String, _ completionHandler: @escaping(_ successfully: Bool) -> Void) {
        //TODO: What is the reason to cast to NSString. This question is related to all casts across this method
        var urlString: NSString = Constants.apiVk + Constants.sendMessage(ownerId: userId, message: message) as NSString
        //TODO: Do not use force unwrap! What is the reason to cast to NSString?
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! as NSString
        if let url = URL(string: urlString as String) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                //TODO: How do you process network errors?
                completionHandler(true)
                }.resume()
        } else {
            completionHandler(false)
        }
    }
    
    static func loadDialogPageMessage(friendId: String, _ completionHandler: @escaping(_ friendListResponse: [DialogListItems]?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.userDialogURL(ownerId: friendId)
        let url = URL(string: urlString)
        //TODO: Force unwrap
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                //TODO: It is also good practice to check that error is nil
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                let messages = try JSONDecoder().decode(DialogListResponse.self, from: data)
                if messages.response.items != nil {
                    var allNormalMessages: [DialogListItems] = []
                    //TODO: FOrce unwrap!!!!!
                    for message in messages.response.items! {
                        if !message.body.isEmpty{
                            allNormalMessages.append(message)
                        }
                    }
                    completionHandler(allNormalMessages.reversed())
                } else {
                    completionHandler([])
                }
            } catch {
                //TODO: I think you forgot to call completionHandler here
                print(error)
            }
        }.resume()
    }
}

private struct DialogListResponse: Decodable {
    var response: DialogListResponseItems
}

private struct DialogListResponseItems: Decodable {
    var count: Int?
    var items: [DialogListItems]?
}

struct DialogListItems: Decodable {
    var id: Int
    var body: String
    var user_id: Int
    var from_id: Int
    var date: Int
    var read_state: Int
    var out: Int
}
