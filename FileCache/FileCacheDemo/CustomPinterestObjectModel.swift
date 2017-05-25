//
//  CustomPinterestObjectModel.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

class CustomPinterestObjectModel: NSObject {
    
    var id:String?
    
    var created_at:NSDate?
    
    var width:Double?
    
    var height:Double?
    
    var color:String?
    
    var likes:Double?
    
    var liked_by_user:Bool
    
    var user:userOfPinterest?
    
    var current_user_collections:[String]?
    
    var urls:UrlsOfPinterestObject?
    
    var categories:[CatagoriesOfPenterestObject]?
    
    var links:NSDictionary?
    
    
    override init () {
        super.init()
    }

    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
//        
//        title = dictionary["title"] as? NSString
//        shortDescription = dictionary["shortDescription"] as? NSString
        
    }
}
