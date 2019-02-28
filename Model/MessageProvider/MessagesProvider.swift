//
//  MessagesProvider.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/26/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class MessagesProvider {
    static func loadMessagesListItems(_ completionHandler: @escaping(_ messagesListResponse: [MessageListItem]?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.getMessages()
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                guard data != nil else {
                    completionHandler(nil)
                    return
                }
                let messages = try JSONDecoder().decode(MessageList.self, from: data!)
                completionHandler(messages.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
}

private struct MessageList: Decodable {
    var response: MessageListItems
}

private struct MessageListItems: Decodable {
    var count: Int?
    var items: [MessageListItem]?
}

struct MessageListItem: Decodable {
    var message: Message?
    var in_read: Int?
    var out_read: Int?
}

struct Message: Decodable{
    var id: Int?
    var user_id: Int?
    var from_id: Int?
    var date: Int?
    var read_state: Int?
    var title: String
    var body: String?
    var userName: String?
    var imageURL: String?
}
