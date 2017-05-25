//
//  CollectionViewCell.swift
//  FileCacheDemo
//
//  Created by Muhammad Dawood on 5/24/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        postInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
    func postInit() {
        imageView = UIImageView(frame: self.contentView.bounds)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
}
