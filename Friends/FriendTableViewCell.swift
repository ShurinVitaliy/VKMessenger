//
//  FriendTableViewCell.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/15/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = 25
        photoImageView.layer.masksToBounds = true
    }
    
    func loadCell(friend: Friend) {
        firstNameLabel.text = friend.first_name
        lastNameLabel.text = friend.last_name
        if friend.online == 0 {
            onlineLabel.text = "offline"
        } else {
            onlineLabel.text = "online"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

