//
//  Utils.h
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 the main Utility class of the project it will used as helping hand for current project
 */
@interface Utils : NSObject


/**
 this will convert the Mega bytes to Bytes

 @param MBs the value in Mega byte
 @return the calculated bytes value
 */
+(double)ConvertMBsToBytes :(double)MBs;

/**
 this method will create the genral time Stamp from current date and time and this will use all over the app

 @return the String value of TimeStamp from current data and time 
 */
+(NSString *)createDownloadDownloadTimeStamp;
@end
