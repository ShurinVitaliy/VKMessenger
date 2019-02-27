//
//  MessagesManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/27/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class MessagesManager {
    //private var messagesProvider: MessagesProvider = MessagesProvider()
    //private var messagesUserProvider: UserProvider = UserProvider()
    //private var messageFullStruct: [MessageListItem] = []
    
    func getFullMessagesList(_ fullStruct: @escaping(_ messagesListResponse: [MessageListItem]?) -> Void) {
        let messagesProvider = MessagesProvider()
        let messagesUserProvider = UserProvider()
        var messageFullStruct: [MessageListItem] = []
        messagesProvider.loadMessagesListItems({(messageListItem) in
            if let messages = messageListItem {
                for message in messages {
                    if (message.message?.title ?? "").isEmpty {
                        if let id = message.message?.user_id {
                            messagesUserProvider.loadUser(userId: id, {(user) in
                                var completeMessage = message
                                completeMessage.message?.title = (user?.first_name ?? "" ) + " " + (user?.last_name ?? "")
                                completeMessage.message?.imageURL = user?.photo_100
                                messageFullStruct.append(completeMessage)
                                fullStruct(messageFullStruct)
                            })
                        }
                    } else {
                        messageFullStruct.append(message)
                    }
                }
                
            } else {
                 fullStruct([])
            }
        })
    }
}
