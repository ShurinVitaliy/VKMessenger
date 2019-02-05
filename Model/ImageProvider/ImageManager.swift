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
    
    func getImage(imageURL: String, complete: @escaping(_ image: UIImage)-> Void) {
        DispatchQueue.main.async {
            let nameOfImage = URL(string: imageURL)?.lastPathComponent
            //TODO: You will load image in the main thread here
            if let image = self.imageCache.loadCacheImage(nameOfImage: nameOfImage!) {
                //TODO: What is the reason of async here?
                complete(image)
            } else {
                self.imageLoader.getImage(photoURL: imageURL, loadCompleteWithResult: {[weak self] (image) in
                    self?.imageCache.saveCacheImage(image: image, nameOfImage: nameOfImage!)
                    DispatchQueue.main.sync {
                        complete(image)
                    }
                })
            }
        }
    }
    
    func clearCache() {
        imageCache.deleteCacheImage()
    }
}
