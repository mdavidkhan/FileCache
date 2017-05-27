//
//  ProfileImages.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

/// sub model of userOfPinterest Model class and it will save as property in that model 
class ProfileImages: NSObject {
    var small:String?
    
    var medium:String?
    
    var large:String?
    
    override init () {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        
        self.init()
        
        self.small = dictionary["small"] as? String
        
        self.medium = dictionary["medium"] as? String
        
        self.large = dictionary["large"] as? String
    }

}
