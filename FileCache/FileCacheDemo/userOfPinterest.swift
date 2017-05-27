//
//  userOfPinterest.swift
//  FileCache
//
//  Created by Muhammad  Dawood on 25/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

/// sub model of CustomePainterestObjectModel and it will save as property in that model 
class userOfPinterest: NSObject {
    
    var id:String?
    
    var username:String?
    
    var name:String?
    
    var profile_image:ProfileImages?
    
    var links:LinksForPinterestUser?
    
    override init () {
        super.init()
    }
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        
        self.init()
        
        self.id = dictionary["id"] as? String
        
        self.username = dictionary["username"] as? String
        
        self.name = dictionary["name"] as? String
        
        var profileImagesModel:ProfileImages?
        
        if let profile_imageDictionary = dictionary["profile_image"] as? [String: AnyObject] {
            profileImagesModel = ProfileImages(profile_imageDictionary)
            
        }
        self.profile_image = profileImagesModel
        
        var linksForPinterestUserModel:LinksForPinterestUser?
        
        if let links_imageDictionary = dictionary["links"] as? [String: AnyObject] {
            linksForPinterestUserModel = LinksForPinterestUser(links_imageDictionary)
            
        }
        
        self.links = linksForPinterestUserModel
    }
}
