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
    private var friend: Friend!
    private var images: [PhotoImageListItems]?
    
    init(friend: Friend) {
        super.init(nibName: "FriendPageView", bundle: nil)
        self.friend = friend
        loadImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = friend.first_name
        print(view.frame)
        (view as? FriendPageView)?.setupDataHeader(friend: friend)
        (view as? FriendPageView)?.delegate = self
    }

    private func loadImages() {
        UserPageProvider.loadFriendPageImage(friendId: String(friend!.id!), {[weak self] (images) in
            DispatchQueue.main.sync {
                self?.images = images
                (self?.view as? FriendPageView)?.bodyImageCollectionView.reloadData()
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
