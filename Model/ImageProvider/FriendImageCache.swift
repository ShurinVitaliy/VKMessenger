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

    init?() {
        try? FileManager.default.createDirectory(at: self.cachesDirectoryURL!.appendingPathComponent(nameOfImageCachDirectory), withIntermediateDirectories: false, attributes: nil)
        if cachesDirectoryURL?.appendingPathComponent(nameOfImageCachDirectory) == nil {
            return nil
        } else {
            self.pathOfCachDirectoryURL = cachesDirectoryURL?.appendingPathComponent(nameOfImageCachDirectory)
        }
    }
    
    func loadCacheImage(nameOfImage: String,loadCompleteWithResult: @escaping(_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let filePath = self.pathOfCachDirectoryURL?.appendingPathComponent(nameOfImage).path else {
                return
            }
            if FileManager.default.fileExists(atPath: filePath) {
                print(filePath)
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
        guard let filePaths = try? fileManager.contentsOfDirectory(at: pathOfCachDirectoryURL!, includingPropertiesForKeys: nil, options: []) else { return }
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
}
