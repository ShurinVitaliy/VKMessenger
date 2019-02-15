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
    private var imageManager = ImageManager.shared
    private var transitionAnimation: CATransition!
    private let cellName = String(describing: FriendTableViewCell.self)
    
    private lazy var refreshControl: UIRefreshControl = {
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
        transitionAnimation = createTransitionAnimation()
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
        FrendsProvider.loadFriends({[weak self] (friends) in
            DispatchQueue.main.async {
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
    
    private func createTransitionAnimation() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.7
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromBottom
        return transition
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
        self.navigationController?.view.layer.add(transitionAnimation, forKey: nil)
        self.navigationController?.pushViewController(friendPageController, animated: false)
        self.tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}
