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
    
    func configureSelf(urlImage: String) {
        let url = URL(string: urlImage)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                
                DispatchQueue.main.sync {
                    let imageView = UIImage(data: data!)
                    self.photoImageView.image = imageView
                }
            } catch {
                print(error)
                self.photoImageView.image = #imageLiteral(resourceName: "defaultImage.png")
            }
        }.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = 25
        photoImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
