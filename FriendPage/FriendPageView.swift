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
    @IBOutlet var friendPageHeader: FriendPageHeader? = FriendPageHeader()
    private let cellName = FriendPageCollectionViewCell.cellName
    weak var delegate: FriendPageViewDeleage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bodyImageCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        bodyImageCollectionView.delegate = self
        bodyImageCollectionView.dataSource = self
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
