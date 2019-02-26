//
//  LeftTableViewCell.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/19/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

//TODO: LeftTableViewCell and RightTableViewCell has absolutely the same logic so it should be one cell class with possibility to configure text padding
class LeftTableViewCell: UITableViewCell, NibLoadableTableViewCell {

    @IBOutlet var messageView: UIView!
    @IBOutlet var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageView.layer.cornerRadius = 10
        messageView.clipsToBounds = true
    }
}
