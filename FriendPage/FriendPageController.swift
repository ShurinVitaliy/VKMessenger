//
//  FriendPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendPageController: UIViewController {
    private let imageManager = ImageManager()
    private var friend: Friend
    private var friendPageView: FriendPageView? {
        return (view as? FriendPageView)
    }
    private var images: [PhotoImageListItems]?
    
    init(friend: Friend) {
        self.friend = friend
        //TODO: What nib name will be used if you will pass nil?
        super.init(nibName: "FriendPageView", bundle: nil)
        
        loadImagesUrl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = friend.first_name
        print(view.frame)
        friendPageView?.friendPageHeader?.setupData(friend: friend)
        friendPageView?.delegate = self
    }

    private func loadImagesUrl() {
        UserPageProvider.loadFriendPageImage(friendId: String(friend.id), {[weak self] (images) in
            //TODO: What is the reason to use sync?
            // я думаю что есть вероятность стучаться к images с разных потоков одновременно, также как у меня была ошибка в FriendsController где я стучался г друзьям из бэкграундного потока
            DispatchQueue.main.sync {
                self?.images = images
                self?.friendPageView?.bodyImageCollectionView.reloadData()
            }
        })
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
