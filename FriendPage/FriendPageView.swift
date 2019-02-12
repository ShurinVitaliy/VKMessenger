//
//  FriendPageView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/8/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

protocol FriendPageViewDeleage: class {
    func loadImage(indexImage: Int, completion: @escaping (_ image: UIImage) -> Void)
    func countOfImage() -> Int
}

class FriendPageView: UIView {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var bodyImageCollectionView: UICollectionView!
    @IBOutlet var friendPageHeader: FriendPageHeader! = FriendPageHeader()
    private var allUserImage: [UIImage]? = [#imageLiteral(resourceName: "defaultImage.png")]
    private let cellName = String(describing: FriendPageCollectionViewCell.self)
    weak var delegate: FriendPageViewDeleage?
    
    override func awakeFromNib() {
        bodyImageCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        bodyImageCollectionView.delegate = self
        bodyImageCollectionView.dataSource = self
    }
    
    func setupDataHeader(friend: Friend) {
        friendPageHeader.setupData(friend: friend)
        
        
    }
    
    private func getImage(indexPath: IndexPath){
        delegate?.loadImage(indexImage: indexPath.row, completion: {[weak self] (image) in
            (self?.bodyImageCollectionView.cellForItem(at: indexPath) as? FriendPageCollectionViewCell)?.imageView.image = image
            //в чём проблема? обращаюсь к ячейке по indexPath и иногда выскакивает то что она равна нил(почти всегда)
        })
    }
}

extension FriendPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bodyImageCollectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! FriendPageCollectionViewCell
        cell.imageView.image = nil
        getImage(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.countOfImage() ?? 0
    }
}