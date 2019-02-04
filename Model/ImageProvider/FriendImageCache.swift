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
    func loadCacheImage(nameOfImage: String) -> UIImage?
    func saveCacheImage(image: UIImage, nameOfImage: String)
    func deleteCacheImage()
}

class CustomImageCache: FriendImageCache {
                                            // я нашёл статью в интернете, там сказано что нужно сохранять кэш в папку Library/Caches, так как Cloud (и iTunes) исключает эту директорию из бэкапа
                                            //TODO: Why is it called documentsURL?
    private let cachesDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: .userDomainMask).first!
                                            //TODO: non informative name
    private let pathOfCachDirectoryURL: URL!
    private let nameOfImageCachDirectory = "ImageCach"
                                            //TODO: Probably it will be better to use failable initializer here
    init() {
                                            //ImageCach string is used across this file in several places so it should be a constant
        try? FileManager.default.createDirectory(at: self.cachesDirectoryURL.appendingPathComponent(nameOfImageCachDirectory), withIntermediateDirectories: false, attributes: nil)
        self.pathOfCachDirectoryURL = cachesDirectoryURL.appendingPathComponent(nameOfImageCachDirectory)
    }

    func loadCacheImage(nameOfImage: String) -> UIImage? {
        let filePath = self.pathOfCachDirectoryURL.appendingPathComponent(nameOfImage).path
        if FileManager.default.fileExists(atPath: filePath) {
            print(filePath)
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }

    func saveCacheImage(image: UIImage, nameOfImage: String) {
        do {
            let fileURL = pathOfCachDirectoryURL.appendingPathComponent(nameOfImage)
            print(fileURL)
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("error")
        }
    }

    func deleteCacheImage() {
        let fileManager = FileManager.default
        guard let filePaths = try? fileManager.contentsOfDirectory(at: pathOfCachDirectoryURL, includingPropertiesForKeys: nil, options: []) else { return }
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
}
