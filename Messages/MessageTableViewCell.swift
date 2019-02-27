//
//  MessageTableViewCell.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/26/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell, NibLoadableTableViewCell{
    
    @IBOutlet weak var dialogImage: UIImageView!
    @IBOutlet weak var dialogName: UILabel!
    @IBOutlet weak var dialogBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dialogImage.layer.cornerRadius = 25
        dialogImage.layer.masksToBounds = true
    }
}
