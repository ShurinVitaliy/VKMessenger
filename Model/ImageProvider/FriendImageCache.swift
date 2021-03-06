//
//  FriendImageCache.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/31/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

protocol FriendImageCache {
    func loadCacheImage(nameOfImage: String,loadCompleteWithResult: @escaping(_ image: UIImage?) -> Void)
    func saveCacheImage(image: UIImage, nameOfImage: String)
    func deleteCacheImage()
}

class CustomImageCache: FriendImageCache {
    
    private let cachesDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: .userDomainMask).first
    private let pathOfCachDirectoryURL: URL?
    private let nameOfImageCachDirectory = "ImageCach"
    private var imageCacheInOperatonMemory: [String: UIImage] = [:]
    private var observer: NSObjectProtocol?
    
    init?() {
        
        try? FileManager.default.createDirectory(at: self.cachesDirectoryURL!.appendingPathComponent(nameOfImageCachDirectory), withIntermediateDirectories: false, attributes: nil)
        if cachesDirectoryURL?.appendingPathComponent(nameOfImageCachDirectory) == nil {
            return nil
        } else {
            self.pathOfCachDirectoryURL = cachesDirectoryURL?.appendingPathComponent(nameOfImageCachDirectory)
        }
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [weak self] notification in
            self?.imageCacheInOperatonMemory.removeAll()
        }
    }
    
    func loadCacheImage(nameOfImage: String,loadCompleteWithResult: @escaping(_ image: UIImage?) -> Void) {
        DispatchQueue.main.async {
            guard let filePath = self.pathOfCachDirectoryURL?.appendingPathComponent(nameOfImage).path else {
                return
            }
            
            if let image = self.imageCacheInOperatonMemory[nameOfImage] {
                loadCompleteWithResult(image)
            } else if FileManager.default.fileExists(atPath: filePath) {
                self.imageCacheInOperatonMemory[nameOfImage] = UIImage(contentsOfFile: filePath)
                loadCompleteWithResult(UIImage(contentsOfFile: filePath))
            } else {
                loadCompleteWithResult(nil)
            }
        }
    }

    func saveCacheImage(image: UIImage, nameOfImage: String) {
        do {
            guard let fileURL = pathOfCachDirectoryURL?.appendingPathComponent(nameOfImage) else {
                return
            }
            imageCacheInOperatonMemory[nameOfImage] = image
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("error")
        }
    }

    func deleteCacheImage() {
        let fileManager = FileManager.default
        imageCacheInOperatonMemory.removeAll()
        guard let filePaths = try? fileManager.contentsOfDirectory(at: pathOfCachDirectoryURL!, includingPropertiesForKeys: nil, options: []) else { return }
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
    deinit {
        guard let observer = observer else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
    }
}
