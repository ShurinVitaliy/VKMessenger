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
    private let documentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: .userDomainMask).first!
    private var pathURL: URL!
    init() {
        do {
            try FileManager.default.createDirectory(at: self.documentsURL.appendingPathComponent("ImageCach"), withIntermediateDirectories: false, attributes: nil)
        } catch {
            print("file is exists")
        }
        self.pathURL = documentsURL.appendingPathComponent("ImageCach")
    }

    func loadCacheImage(nameOfImage: String) -> UIImage? {
        let filePath = self.pathURL.appendingPathComponent(nameOfImage).path
        if FileManager.default.fileExists(atPath: filePath) {
            print(filePath)
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }

    func saveCacheImage(image: UIImage, nameOfImage: String) {
        do {
            let fileURL = pathURL.appendingPathComponent(nameOfImage)
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
        guard let filePaths = try? fileManager.contentsOfDirectory(at: pathURL, includingPropertiesForKeys: nil, options: []) else { return }
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
}
