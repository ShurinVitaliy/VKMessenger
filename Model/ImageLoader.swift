//
//  ImageLoader.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/21/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    let imageURLString: String!
    var imageView: UIImage!
    
    init(imageURLString: String) {
        self.imageURLString = imageURLString
    }
    
    func getImage(indexPath: IndexPath, loadCompleteWithResult: @escaping(_ indexPath: IndexPath,_ image: UIImage) -> Void) {
        let url = URL(string: imageURLString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                DispatchQueue.main.sync {
                    let imageView = UIImage(data: data!)
                    loadCompleteWithResult(indexPath, imageView ?? #imageLiteral(resourceName: "defaultImage.png"))
                }
            }
        }.resume()
    }
}
