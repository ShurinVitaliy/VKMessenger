//
//  CustomIL.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/30/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

protocol FriendImageLoader {
    func getImage(photoURL: String, loadCompleteWithResult: @escaping(_ image: UIImage) -> Void) -> Void
}

class CustomImageLoader: FriendImageLoader{
    func getImage(photoURL: String ,loadCompleteWithResult: @escaping(_ image: UIImage) -> Void) {
        let url = URL(string: photoURL)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                if data != nil {
                    if let imageView = UIImage(data: data!) {
                        loadCompleteWithResult(imageView)
                    }
                }
            }
        }.resume()
    }
}
