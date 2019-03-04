//
//  FriendPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendPageController: UIViewController {
    private var imageManager = ImageManager.shared
    
    private var friend: Friend
    private var friendPageView: FriendPageView? {
        return (view as? FriendPageView)
    }
    private var images: [PhotoImageListItems]?
    
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
        loadImagesUrl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = friend.first_name
        friendPageView?.delegate = self
        friendPageView?.friendPageHeader?.setupData(friend: friend)
        friendPageView?.friendPageHeader?.sendMessageButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        friendPageView?.friendPageHeader?.infoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage)))
    }

    
    private func loadImagesUrl() {
        UserPageProvider.loadFriendPageImage(friendId: String(friend.id), {[weak self] (images) in
            DispatchQueue.main.async {
                self?.images = images
                self?.friendPageView?.bodyImageCollectionView.reloadData()
            }
        })
    }
    
    @objc private func pickImage(sender: UITapGestureRecognizer) {
        
        UserProvider.loadUser(userId: friend.id, {[weak self] (user) in
            DispatchQueue.main.async {
                guard var user = user else {
                    return
                }
                if user.bdate.isEmpty {
                    user.bdate = "private information"
                }
                if user.status.isEmpty {
                    user.status = "private information"
                }
        
                let infoPageController = InfoPageController(status: user.status, bdata: user.bdate)
                self?.navigationController?.pushViewController(infoPageController, animated: false)
            }
        })
        /*
        let infoPageController = InfoPageController(status: "ds", bdata: "qwe")
        navigationController?.pushViewController(infoPageController, animated: false)
        //present(infoPageController, animated: true, completion: nil)
        let infoPageController = InfoPageController()
        present(infoPageController, animated: true, completion: nil)*/
    }
    
    @objc private func sendMessage(_ sender: UIButton) {
        let dialogPageController = DialogPageController(friend: friend)
        self.navigationController?.pushViewController(dialogPageController, animated: true)
    }
}

extension FriendPageController: FriendPageViewDeleage {
    func countOfImage() -> Int {
        return images?.count ?? 0
    }
    
    func loadImage(indexImage: Int, completion: @escaping (UIImage) -> Void) {
        imageManager.getImage(imageURL: images![indexImage].sizes[1].url, complete: completion)
    }
}
