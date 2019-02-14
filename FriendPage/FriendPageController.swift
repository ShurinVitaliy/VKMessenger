//
//  FriendPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendPageController: UIViewController {
    private var imageManager = ImageManager()
    private var friend: Friend
    private var friendPageView: FriendPageView? {
        return (view as? FriendPageView)
    }
    private var images: [PhotoImageListItems]?
    
    init(friend: Friend) {
        self.friend = friend
        //TODO: What nib name will be used if you will pass nil? (describing: FriendPageView.self)
        super.init(nibName: nil, bundle: nil)// он ищет файл пера с соответствующим именем (без расширения) и загружает этот ксиб файл всякий раз, когда запрашивается его представление. имя которого совпадает с именем класса без слова «Контроллер», как в .MyViewControllerMyView.nib ИЛИ  имя которого совпадает с именем класса контроллера представления. Например, если имя класса - это, он ищет файл.MyViewControllerMyViewController.nib
        //нашёл)
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
            // я думаю что есть вероятность стучаться к images с разных потоков одновременно, также как у меня была ошибка в FriendsController где я стучался к друзьям из бэкграундного потока и основного 
            DispatchQueue.main.async {
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
