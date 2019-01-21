//
//  FriendTableViewCell.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/15/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//
import Foundation
import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = 25
        photoImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}



/*
 func configureSelf(model: Friend) {
 firstNameLabel.text = model.first_name
 lastNameLabel.text = model.last_name
 let url = URL(string: model.photo_50_URL!)
 URLSession.shared.dataTask(with: url!) {(data, response, error) in
 do {
 DispatchQueue.main.sync {
 let imageView = UIImage(data: data!)
 self.photoImageView.image = imageView
 }
 }
 }.resume()
 }
 */
