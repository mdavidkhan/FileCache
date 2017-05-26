//
//  LinksForPinterestObject.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

class LinksForPinterestUser: NSObject {
    
    var selfURLString:String?
    
    var html:String?
    
    var photos:String?
    
    var likes:String?
    
    override init () {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        
        self.init()
        
        self.selfURLString = dictionary["self"] as? String
        
        self.html = dictionary["html"] as? String
        
        self.photos = dictionary["photos"] as? String
        
        self.likes = dictionary["likes"] as? String
    }
}
