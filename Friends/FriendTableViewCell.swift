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
    //TODO: Documentation note: If you override this method, you must be sure to invoke the superclass implementation.
    override func prepareForReuse() {
        photoImageView.image = nil
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
}

