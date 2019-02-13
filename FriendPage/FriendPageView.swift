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
//TODO: Fix UICOllectionView warnings in console
class FriendPageView: UIView {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var bodyImageCollectionView: UICollectionView!
    //TODO: Why it is force unwrapped?
    @IBOutlet var friendPageHeader: FriendPageHeader! = FriendPageHeader()
    //TODO: Is it really needed
    private var allUserImage: [UIImage]? = [#imageLiteral(resourceName: "defaultImage.png")]
    //Please create generic estention. So any cell will contain property cellName when you access this property String(describing: CellType.self) will be returned. Read about generics.
    private let cellName = String(describing: FriendPageCollectionViewCell.self)
    weak var delegate: FriendPageViewDeleage?
    
    override func awakeFromNib() {
        //TODO: Do not forget to call super
        bodyImageCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        bodyImageCollectionView.delegate = self
        bodyImageCollectionView.dataSource = self
    }
    
    //TODO: This can be in controller. TODO: Remind me to explain why
    func setupDataHeader(friend: Friend) {
        friendPageHeader.setupData(friend: friend)
    }
}

extension FriendPageView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! FriendPageCollectionViewCell
        cell.imageView.image = nil
        delegate?.loadImage(indexImage: indexPath.row, completion: {(image) in
            cell.imageView.image = image
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.countOfImage() ?? 0
    }
}

