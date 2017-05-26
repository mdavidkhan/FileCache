//
//  PinterestArray+CustomeAction.swift
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit

private var MaxNumberAssociationKey: UInt8 = 0

extension NSMutableArray {
    
    var maximimNumberForNewFilesLoading:Double! {
        get {
            let oldValue = objc_getAssociatedObject(self, &MaxNumberAssociationKey) as? Double
            if (oldValue?.isNaN)! {
                return 10
            }
            return oldValue
        }
        set(newValue) {
            objc_setAssociatedObject(self, &MaxNumberAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
  func addLatestObjectsFromArray (backUpArray:[CustomPinterestObjectModel])  {
    
    let firstMaxObject = backUpArray[0..<Int(maximimNumberForNewFilesLoading)]
    for object in firstMaxObject{
        self.add(object)
    }

    }
}
