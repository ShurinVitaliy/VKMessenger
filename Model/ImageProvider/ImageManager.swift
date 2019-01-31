//
//  ImageManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/31/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class ImageManager {
    private let imageLoader: FriendImageLoader = CustomImageLoader()
    private let imageCache: FriendImageCache = CustomImageCache()
    
    func getImage(friend: Friend,complete: @escaping(_ image: UIImage)-> Void) {
        let nameOfImage = String(friend.id!)
        if let image = imageCache.loadCacheImage(nameOfImage: nameOfImage) {
            DispatchQueue.global().async {
                complete(image)
            }
        } else {
            self.imageLoader.getImage(photoURL: friend.photo_50!, loadCompleteWithResult: {[weak self] (image) in
                self?.imageCache.saveCacheImage(image: image, nameOfImage: nameOfImage)
                complete(image)
            })
        }
    }
    
    func clearCache() {
        imageCache.deleteCacheImage()
    }
}
