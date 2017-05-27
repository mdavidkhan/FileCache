//
//  UrlsOfPinterestObject.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

/// sub model of CustomePainterestObjectModel and it will save as property in that model 
class UrlsOfPinterestObject: NSObject {

    var raw:String?
    
    var full:String?
    
    var regular:String?
    
    var small:String?
    
    var thumb:String?
    
    override init () {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        
        self.init()
    
        self.raw = dictionary["raw"] as? String
        
        self.full = dictionary["full"] as? String
        
        self.regular = dictionary["regular"] as? String
        
        self.small = dictionary["small"] as? String
        
        self.thumb = dictionary["thumb"] as? String
    }
}
