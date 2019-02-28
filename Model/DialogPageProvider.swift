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
        let urlString = Constants.apiVk + Constants.sendMessage(ownerId: userId, message: message)
        if let urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let url = URL(string: urlString as String) {
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) {(data, response, error) in
                    if error?._code ==  NSURLErrorTimedOut {
                        print("Time Out")
                        completionHandler(false)
                    } else {
                        completionHandler(true)
                    }
                }.resume()
            } else {
                completionHandler(false)
            }
        }

    }
    
    static func loadDialogPageMessage(friendId: String, _ completionHandler: @escaping(_ friendListResponse: [DialogListItems]?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.userDialogURL(ownerId: friendId)
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                let messages = try JSONDecoder().decode(DialogListResponse.self, from: data)
                if let messages =  messages.response.items {
                    var allNormalMessages: [DialogListItems] = []
                    for message in messages {
                        if !message.body.isEmpty{
                            allNormalMessages.append(message)
                        }
                    }
                    completionHandler(allNormalMessages.reversed())
                } else {
                    completionHandler([])
                }
            } catch {
                completionHandler(nil)
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


//TODO: What is the reason to cast to NSString //я уже не понмю, просто столкнулся с проблемой символов, русский не отправлял и пробелы тоже - решил что нужно кодировать - нашёл первую нормальную статью на стаке и заимплементил себе в код. This question is related to all casts across this method
