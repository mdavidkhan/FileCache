//
//  PinterestArray+CustomeAction.swift
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

import UIKit


/// this will used to identify the associseated object for MaxNumaber for new files loading
private var MaxNumberAssociationKey: UInt8 = 0

// MARK: - extention to NSmutable array for main view controller 
extension NSMutableArray {
    
    /// store the MAX number of files loading at a time by main view controller (By default this value is 10 )
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
    
    
    func addLatestObjectsFromArray ( backUpArray:[CustomPinterestObjectModel])  {
        
        var backUpArray = backUpArray

        if (backUpArray.count >= Int(maximimNumberForNewFilesLoading)) {
          let firstMaxObject = backUpArray[0..<Int(maximimNumberForNewFilesLoading)]
            for object in firstMaxObject{
                self.add(object)
                
            }
        }
        else if backUpArray.count > 0{
            let firstMaxObject = backUpArray
            for object in firstMaxObject{
                self.add(object)
                
            }

        }
       
        
    }
}
