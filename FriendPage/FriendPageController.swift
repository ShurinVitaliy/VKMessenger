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
    //TODO: What is the reason to have use implicit unwrapping here
    private var friend: Friend!
    private var images: [PhotoImageListItems]?
    
    init(friend: Friend) {
        //TODO: What nib name will be used if you will pass nil?
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
        //TODO: Replace (view as? FriendPageView) with computed property to do not copy paste it all time
        (view as? FriendPageView)?.setupDataHeader(friend: friend)
        (view as? FriendPageView)?.delegate = self
    }

    private func loadImages() {
        //TODO: Do not use force unwrap. I already told you about it!
        UserPageProvider.loadFriendPageImage(friendId: String(friend!.id!), {[weak self] (images) in
            //TODO: What is the reason to use sync?
            DispatchQueue.main.sync {
                self?.images = images
                //TODO: Replace (view as? FriendPageView) with computed property to do not copy paste it all time
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
