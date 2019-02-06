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
    private var friend: Friend?
    
    init(friend: Friend) {
        super.init(frame: CGRect.zero)
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
        self.friend = friend
        setupText()
        setupImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if UIDevice.current.orientation.isLandscape {
            sendMessageButton.frame = CGRect(x: 370, y: 80, width: 200 , height: 40)
            addToFreindsButton.frame = CGRect(x: 370, y: 135, width: 200 , height: 40)
        } else {
            sendMessageButton.frame = CGRect(x: 14, y: 196, width: 165 , height: 35)
            addToFreindsButton.frame = CGRect(x: 195, y: 196, width: 165 , height: 35)
        }
    }
    
    private func setupUserImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 14, y: 80, width: 100, height: 100))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func setupUserLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 128, y: 85, width: 200, height: 30))
        label.font = label.font.withSize(20)
        return label
    }
    
    private func setupOnlineLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 128, y: 115, width: 50, height: 30))
        label.font = label.font.withSize(12)
        return label
    }
    
    private func setupRegionLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 128, y: 145, width: 100, height: 30))
        label.font = label.font.withSize(14)
        return label
    }
    
    private func setupSendMessageButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 14, y: 196, width: 165 , height: 35))
        button.setTitle("Message", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8239048719, green: 0.8419965506, blue: 0.8625177741, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }
    
    private func setupAddToFreindsButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 195, y: 196, width: 165 , height: 35))
        button.setTitle("Friends", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1), for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.8239048719, green: 0.8419965506, blue: 0.8625177741, alpha: 1)
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }
    
    private func setupInfoImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 301, y: 115, width: 30, height: 30))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.image = #imageLiteral(resourceName: "info")
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func setupText() {
        userLabel.text = friend!.first_name! + " " + friend!.last_name!
        onlineLabel.text = (friend!.online == 1 ? "online" : "ofline" )
        regionLabel.text = "not Found"
    }
    
    private func setupImage() {
        let imageManager = ImageManager()
        imageManager.getImage(imageURL: friend!.photo_100! , complete: {[weak self] (image) in
            self?.userImageView.image = image
        })
    }
}
