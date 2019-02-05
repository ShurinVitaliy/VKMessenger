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
    private var controller: UINavigationController!
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

    convenience init(controller: UINavigationController) {
        self.init(nibName: nil, bundle: nil)
        self.controller = controller
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        setupNavigationController()
    }
    
    override func loadView() {
        loadFreinds()
        tableView = FriendsTableView()
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
                            //TODO: Explain me what is wrong with this code
                            //не было [weak self], поэтому возникaл ретейн цикл, объекты никогда не удалялись из памяти,
        FrendsProvider.loadFriends({[weak self] (friendsStructureReceivedSuccessfully) in
            self?.friends = friendsStructureReceivedSuccessfully
            DispatchQueue.main.sync {
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                                        //TODO: This should be inside of prepareForReuse method. Read about this method and explain me when it can be used
                                        //Готовит многократно используемую ячейку для повторного использования делегатом табличного представления.
                                        //cell.photoImageView.image = nil
                self.getImage(indexPath: indexPath, imageURL: friend.photo_100!)
        }
        return cell
    }
    
}
extension FriendsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendPageController = FriendPageController(friend: friends![indexPath.row], navigationController: controller)
        
        controller.pushViewController(friendPageController, animated: true)
    }
}
