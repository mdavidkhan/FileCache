//
//  CatagoriesOfPenterestObject.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit
/// sub model of CustomePainterestObjectModel and it will save as property in that model 
class CatagoriesOfPenterestObject: NSObject {

    var id: Double?
    
    var title: String?
    
    var photo_count:Double?
    
    var links_self:String?
    
    var Links_photos:String?
    
    override init () {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        
        self.init()
        
        self.id = (dictionary["id"] as? NSNumber) as? Double
        
        self.title = dictionary["title"] as? String
        
        self.photo_count = (dictionary["photo_count"] as? NSNumber) as? Double
        
        if let linksDictionary = dictionary["Links"] as? [String: AnyObject] {
            
            self.links_self = linksDictionary["self"] as? String
            
            self.Links_photos = linksDictionary["photos"] as? String
        }
       
    }

}
