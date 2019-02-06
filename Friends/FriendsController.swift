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
    private lazy var imageManager = ImageManager()
    let cellName = String(describing: FriendTableViewCell.self)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .darkGray
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadFreinds()
        imageManager.clearCache()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        setupNavigationController()
    }
    
    override func loadView() {
        
        loadFreinds()
        tableView = UITableView()
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.delegate = self
        tableView.dataSource = self
        self.view = tableView
    }
    
    private func setupNavigationController() {
        navigationItem.title = "Friends"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func loadFreinds() {
        refreshControl.beginRefreshing()
        //TODO: There are two problems left with this code:
        //first problem is that you use friendsStructureReceivedSuccessfully (friends) method as closure and as result you will have retain cycle. We discussed similar situation in the past.
        //second problem is that you access self.frieand from background thread. Explain me why it is bad
        //если дейстивия начнут проходить в главном потоке раньше чем self?.friends = friends выдаст что друзей нет
                            //TODO: Explain me what is wrong with this code
                            //не было [weak self], поэтому возникaл ретейн цикл, объекты никогда не удалялись из памяти,
        
        
        FrendsProvider.loadFriends({[weak self] (friends) in
            DispatchQueue.main.sync {
                self?.friends = friends
                if self?.friends == nil {
                    self?.refreshControl.endRefreshing()
                    let alert = UIAlertController(title: "error connection", message: "friends not found, try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {[weak self] (action) in
                        self?.loadFreinds()
                    }))
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        })
    }
    
    private func getImage(indexPath: IndexPath,imageURL: String) {
        imageManager.getImage(imageURL: imageURL, complete: {[weak self] (image) in
            (self?.tableView.cellForRow(at: indexPath) as? FriendTableViewCell)?.photoImageView.image = image
        })
    }

}

extension FriendsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! FriendTableViewCell
        if let friend = friends?[indexPath.row] {
            cell.loadCell(friend: friend)
            cell.photoImageView.image = nil
            getImage(indexPath: indexPath, imageURL: friend.photo_100!)
        }
        return cell
    }
    
}
extension FriendsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendPageController = FriendPageController(friend: friends![indexPath.row])
        self.navigationController?.pushViewController(friendPageController, animated: true)
    }
}




//не могу понять, почему? ведь всё нормально работает, и в замыкании передаю слабую ссылку на self, да и friendsStructureReceivedSuccessfully это масив моих друзей
