//
//  NSDate+CustomeActions.swift
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

// MARK: - Extention to NSdate
extension NSDate{
    
    /// this method to get the NSDate from the string value get from the main API with specific formate ,Note this will work on specific type of date formate it will not parse any other string formate
    ///
    /// - Parameter dateString: the string value get form webservice
    /// - Returns: the date paresed from string 
    class func dateFromPinterestObjectCreationDateString(dateString:String?) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" //Pinterest Object Creation date format 2016-05-29T15:42:02-04:00
        var date:NSDate?
        if (dateString?.characters.count)! > 0 {
            date = dateFormatter.date(from: dateString!) as NSDate? //according to date format the date string
        }
        return date
    }
}
