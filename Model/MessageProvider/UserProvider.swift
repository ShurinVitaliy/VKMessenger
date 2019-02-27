//
//  UserProvider.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/26/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class UserProvider {
    func loadUser(userId: Int, _ completionHandler: @escaping(_ userListResponse: User?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.getUser(ownerId: String(userId))
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                let user = try JSONDecoder().decode(UserList.self, from: data)
                completionHandler(user.response.first )
            } catch {
                print(error)
            }
        }.resume()
    }
}

private struct UserList: Decodable {
    var response: [User]
}

struct User: Decodable {
    var first_name: String
    var id: Int
    var last_name: String
    var photo_100: String
}
