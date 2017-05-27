//
//  CollectionViewCell.swift
//  FileCacheDemo
//
//  Created by Muhammad Dawood on 5/24/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit


/// the custome cell used to display on main collection view
class CollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    
    var timeStamp : NSString!
    
    
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
        imageView.image = UIImage(named: "default-placeholder")
        self.designUIOfCurrentCell()
    }
    
    /// add some detecent animation to the cell
    func addAnimationTOView() {
        let rotation: CATransform3D = CATransform3DMakeRotation((2.0 * .pi) / 180, 0.0, 0.5, 0.5)
        self.contentView.alpha = 0.8
        self.contentView.layer.transform = rotation
        self.contentView.layer.anchorPoint = CGPoint(x: CGFloat(0), y: CGFloat(0.5))
        UIView.animate(withDuration: 0.9, animations: {() -> Void in
            self.contentView.layer.transform = CATransform3DIdentity
            self.contentView.alpha = 1
            self.contentView.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        }, completion: {(_ finished: Bool) -> Void in
        })

    }
    /// this will add the shadow and round corners to  the current class
    func designUIOfCurrentCell(){
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        imageView.image = UIImage(named: "default-placeholder")
    }
    
}
