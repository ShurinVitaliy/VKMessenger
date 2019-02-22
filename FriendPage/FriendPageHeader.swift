//
//  FriendPageHeader.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/5/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageHeader: UIView {
    var userImageView: UIImageView!
    var infoImageView: UIImageView!
    var userLabel: UILabel!
    var onlineLabel: UILabel!
    var regionLabel: UILabel!
    var sendMessageButton: UIButton!
    var addToFreindsButton: UIButton!
    
    func setupData(friend: Friend) {
        let imageManager = ImageManager.shared
        imageManager.getImage(imageURL: friend.photo_100 , complete: {[weak self] (image) in
            self?.userImageView.image = image
        })
        userLabel.text = friend.first_name + " " + friend.last_name
        onlineLabel.text = (friend.online == 1 ? "online" : "ofline" )
        regionLabel.text = "not Found"
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        userImageView = setupUserImageView()
        self.addSubview(userImageView)
        userLabel = setupUserLabel()
        self.addSubview(userLabel)
        onlineLabel = setupOnlineLabel()
        self.addSubview(onlineLabel)
        regionLabel = setupRegionLabel()
        self.addSubview(regionLabel)
        sendMessageButton = setupSendMessageButton()
        self.addSubview(sendMessageButton)
        addToFreindsButton = setupAddToFreindsButton()
        self.addSubview(addToFreindsButton)
        infoImageView = setupInfoImageView()
        self.addSubview(infoImageView)
    }
    
    override func layoutSubviews() {
        if UIDevice.current.orientation.isLandscape {
            sendMessageButton.frame = CGRect(x: 350, y: 14, width: 200 , height: 40)
            addToFreindsButton.frame = CGRect(x: 350, y: 69, width: 200 , height: 40)
        } else {
            sendMessageButton.frame = CGRect(x: 14, y: 130, width: 139 , height: 32)
            addToFreindsButton.frame = CGRect(x: 167, y: 130, width: 139 , height: 32)
        }
    }
    
    private func setupUserImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 14, y: 14, width: 100, height: 100))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    private func setupUserLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 128, y: 19, width: 200, height: 30))
        label.font = label.font.withSize(17)
        return label
    }
    
    private func setupOnlineLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 128, y: 49, width: 50, height: 30))
        label.font = label.font.withSize(12)
        return label
    }
    
    private func setupRegionLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 128, y: 79, width: 100, height: 30))
        label.font = label.font.withSize(14)
        return label
    }
    
    private func setupSendMessageButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 14, y: 130, width: 139 , height: 32))
        button.setTitle("Message", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8239048719, green: 0.8419965506, blue: 0.8625177741, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }
    
    private func setupAddToFreindsButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 167, y: 130, width: 139 , height: 32))
        button.setTitle("Friends", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.8239048719, green: 0.8419965506, blue: 0.8625177741, alpha: 1)
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }
    
    private func setupInfoImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 281, y: 49, width: 20, height: 20))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.image = #imageLiteral(resourceName: "info")
        imageView.clipsToBounds = true
        return imageView
    }
    
}
