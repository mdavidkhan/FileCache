//
//  CollectionViewFooter.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 27/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

class CollectionViewFooter: UICollectionReusableView {
  
    var loadingIndicator:UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
    func postInit() {
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator?.hidesWhenStopped = true
        loadingIndicator?.center = self.center
        
        self.addSubview(loadingIndicator!)
        self.bringSubview(toFront: loadingIndicator!)
    }
}
