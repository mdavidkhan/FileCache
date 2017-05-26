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
    
    var liked_by_user:Bool?
    
    var user:userOfPinterest?
    
    var current_user_collections:[AnyObject]?
    
    var urls:UrlsOfPinterestObject?
    
    var categories:[CatagoriesOfPenterestObject]?
    
    var links:NSDictionary?
    
    
    override init () {
        super.init()
    }

    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        
        self.init()
        self.id = dictionary["id"] as? String
        
       
        self.created_at =  NSDate.dateFromPinterestObjectCreationDateString(dateString: dictionary["created_at"] as? String)
        
        
        self.width = (dictionary["width"] as? NSNumber) as? Double
        
        self.height = (dictionary["height"] as? NSNumber) as? Double
        
        self.color = dictionary["color"] as? String
        
        self.likes = (dictionary["likes"] as? NSNumber) as? Double
        
        self.liked_by_user = dictionary["liked_by_user"] as? Bool
        
        var userOfPinterestModel:userOfPinterest?
        
        if let UserDictionary = dictionary["user"] as? [String: AnyObject] {
            userOfPinterestModel = userOfPinterest(UserDictionary)
            
        }
        
        self.user = userOfPinterestModel
        
        self.current_user_collections = dictionary["current_user_collections"] as? [AnyObject]
        
        var urlsOfPinterestObjectModel:UrlsOfPinterestObject?
        
        if let urlDictionary = dictionary["urls"] as? [String: AnyObject] {
            urlsOfPinterestObjectModel = UrlsOfPinterestObject(urlDictionary)
            
        }
        
        self.urls = urlsOfPinterestObjectModel
        
        var catagoriesModelsArray:[CatagoriesOfPenterestObject]? = []
        
        if let catagoriesJSONObjectsArray = dictionary["categories"] as? NSArray{
            
            var categoriesObjectModel:CatagoriesOfPenterestObject?
            
            for singleObject in catagoriesJSONObjectsArray {
                if let catagoryDictionary = singleObject as? [String: AnyObject] {
                    categoriesObjectModel = CatagoriesOfPenterestObject(catagoryDictionary)
                    
                    catagoriesModelsArray?.append(categoriesObjectModel!)
                }
            }
        }
        
        self.categories = catagoriesModelsArray
        
        self.links = dictionary["links"] as? NSDictionary
        
    }
}
