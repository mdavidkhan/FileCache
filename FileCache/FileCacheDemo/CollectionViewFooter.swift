//
//  CollectionViewFooter.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 27/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

/// the footer view with and animating activity indicator which is used to animate while loading of new cells
class CollectionViewFooter: UICollectionReusableView {
  
    
    /// the loading indicator 
    var loadingIndicator:UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
    /// customaized initilaization
    func postInit() {
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator?.hidesWhenStopped = true
        loadingIndicator?.center = self.center
        
        self.addSubview(loadingIndicator!)
        self.bringSubview(toFront: loadingIndicator!)
    }
}
