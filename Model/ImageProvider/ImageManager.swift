//
//  ImageManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/31/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class ImageManager {
    //TODO: I think it will be good to share cache across application so please make ImageManager as syngleton.
    private let imageLoader: FriendImageLoader = CustomImageLoader()
    private let imageCache: FriendImageCache? = CustomImageCache()
    //TODO: please move it to CustomImageCache. We can discuss if you do not understand why it should be at CustomImageCache
    private var imageCacheInOperatonMemory: [String: UIImage] = [:]
    
    init() {
        //TODO: What about unregistering? Is it obligatory?
        //TODO: please move it to CustomImageCache.
        NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [weak self] notification in
            self?.imageCacheInOperatonMemory.removeAll()
        }
    }
    
    func getImage(imageURL: String, complete: @escaping(_ image: UIImage)-> Void) {
        let nameOfImage = URL(string: imageURL)?.lastPathComponent
        if let image = self.imageCacheInOperatonMemory[nameOfImage!] {
            DispatchQueue.main.async {
                complete(image)
            }
        } else {
            self.imageCache?.loadCacheImage(nameOfImage: nameOfImage!, loadCompleteWithResult: {[weak self] (image) in
                if image != nil {
                        complete(image!)
                        self?.imageCacheInOperatonMemory[nameOfImage!] = image
                } else {
                    self?.imageLoader.getImage(photoURL: imageURL, loadCompleteWithResult: {[weak self] (image) in
                        self?.imageCache!.saveCacheImage(image: image, nameOfImage: nameOfImage!)
                        DispatchQueue.main.sync {
                            complete(image)
                            self?.imageCacheInOperatonMemory[nameOfImage!] = image
                        }
                    })
                }
            })
        }
    }
    func clearCache() {
        imageCache?.deleteCacheImage()
    }
}
