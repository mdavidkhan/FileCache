//
//  NSDate+CustomeActions.swift
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

extension NSDate{
    
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
