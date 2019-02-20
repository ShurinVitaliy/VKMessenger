//
//  FriendPageCollectionViewCell.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/12/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

public protocol NibLoadableView: class {
    static var cellName: String { get }
}

class FriendPageCollectionViewCell: UICollectionViewCell, NibLoadableView {
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
    }
}

extension NibLoadableView where Self: UICollectionViewCell {
    static var cellName: String {
        return String(describing: self)
    }
}
