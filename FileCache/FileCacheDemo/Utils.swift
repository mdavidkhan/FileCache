//
//  Utils.swift
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

class Utils: NSObject {

    class func addLatestObjectsToArray (toArray:NSMutableArray,frombackUpArray:[CustomPinterestObjectModel],numberOfObject:Int)  {
        var firstMaxObject:[CustomPinterestObjectModel]? = []
        if frombackUpArray.count >= numberOfObject {
            firstMaxObject = Array(frombackUpArray.prefix(numberOfObject))
        }
        else{
            
            firstMaxObject = Array(frombackUpArray.prefix(frombackUpArray.count))
        }
        for object in firstMaxObject!{
            toArray.add(object)
        }
    }
}
