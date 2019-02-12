//
//  UserPageProvider.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/8/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

class UserPageProvider {
    
    static func loadFriendPageImage(friendId: String, _ completionHandler: @escaping(_ friendListResponse: [PhotoImageListItems]?) -> Void) {
        let urlString: String = Constants.apiVk + Constants.userPhotosURL(ownerId: friendId)
        let url = URL(string: urlString)
        print(url)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                let images = try JSONDecoder().decode(PhotoImageList.self, from: data)
                completionHandler(images.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
}

private struct PhotoImageList: Decodable {
    var response: PhotoImageListResponseItems
}

private struct PhotoImageListResponseItems: Decodable {
    var count: Int?
    var items: [PhotoImageListItems]?
}

struct PhotoImageListItems: Decodable {
    var id: Int
    var album_id: Int
    var owner_id: Int
    var sizes: [SizesImages]
}

struct SizesImages: Decodable {
    var type: String
    var url: String
    var width: Int
    var height: Int
}
