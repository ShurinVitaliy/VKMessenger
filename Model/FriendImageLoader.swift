//
//  CustomIL.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/30/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class CustomImageLoade{
    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func getImage(friend: Friend ,loadCompleteWithResult: @escaping(_ image: UIImage) -> Void) {
        let url = URL(string: friend.photo_50!)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let imageView = UIImage(data: data!)
                loadCompleteWithResult(imageView ?? #imageLiteral(resourceName: "defaultImage.png"))
            }
            }.resume()
    }
    
    func loadCacheImage(nameOfImage: String) -> UIImage? {
        let filePath = documentsURL.appendingPathComponent("\(nameOfImage).jpg").path
        if FileManager.default.fileExists(atPath: filePath) {
            print(filePath)
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }
    
    func uploadCacheImage(image: UIImage, nameOfImage: String) {
        do {
            let fileURL = documentsURL.appendingPathComponent("\(nameOfImage).jpg")
            print(fileURL)
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
        } catch {
            print("error")
        }
    }
}
