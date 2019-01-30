//
//  CacheFileManager.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/28/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendsCache {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func uploadCacheImage(image: UIImage, name: String) {
        do {
            let fileURL = documentsURL.appendingPathComponent("\(name).jpg")
            print(fileURL)
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("error")
        }
    }
    
    func loadCache(name: String) -> UIImage? {
        let filePath = documentsURL.appendingPathComponent("\(name).jpg").path
        if FileManager.default.fileExists(atPath: filePath) {
            print(filePath)
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }
}
