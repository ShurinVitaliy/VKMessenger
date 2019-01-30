//
//  FriendsController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FriendsController: UIViewController {
    private var friends: [Friend]?
    private var tableView: UITableView!
    private lazy var imageLoader = ImageLoader()
    private lazy var cache = FriendsCache()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .darkGray
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadFreinds()
    }

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = createTableView()
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        loadFreinds()
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")
        return tableView
    }
    
    private func loadFreinds() {
        refreshControl.beginRefreshing()
        FrendsProvider.loadFriends(completeGetFreiendsWithResult)
    }
    
    private func completeGetFreiendsWithResult(friendsStructureReceivedSuccessfully: [Friend]?) {
        friends = friendsStructureReceivedSuccessfully
        DispatchQueue.main.async {
            if self.friends == nil {
                self.refreshControl.endRefreshing()
                let alert = UIAlertController(title: "error connection", message: "friends not found, try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in
                    self.loadFreinds()
                }))
                self.present(alert, animated: true, completion: nil)
                
            } else if (self.tableView != nil) {
               // self.friendCache.uploadCache(friend: self.friends ?? [])
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func getImage(indexPath: IndexPath,friend: Friend) {
        
        let nameOfImageCurrentFriend = String(friend.id!)
        if let image = cache.loadCache(name: nameOfImageCurrentFriend) {
            DispatchQueue.main.sync {
                (tableView.cellForRow(at: indexPath) as? FriendTableViewCell)?.photoImageView.image = image
            }
        } else {
            imageLoader.getImage(friend: friend, loadCompleteWithResult: {[weak self] (image) in
                DispatchQueue.main.sync { //вызывающий поток ожидает выполнения вашей задачи
                    (self?.tableView.cellForRow(at: indexPath) as? FriendTableViewCell)?.photoImageView.image = image
                    self?.cache.uploadCacheImage(image: image, name: nameOfImageCurrentFriend)
                }
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FriendsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        if let friend = friends?[indexPath.row] {
            cell.loadCell(friend: friend)
            
            DispatchQueue.global().async {
                self.getImage(indexPath: indexPath, friend: friend)
            }
        }
        return cell
    }
}
extension FriendsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
