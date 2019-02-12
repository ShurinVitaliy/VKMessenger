//
//  FriendPageCollectionViewCell.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/12/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupImage(image: UIImage) {
        imageView.image = image
    }
    
}
