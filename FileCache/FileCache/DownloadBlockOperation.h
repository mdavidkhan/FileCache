//
//  DownloadBlockOperation.h
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 this is sub class of NS Block oaperation it is used to store the extra information of operation currently we are using only on extra value
 */
@interface DownloadBlockOperation : NSBlockOperation

/**
 this hold the timeStamp of the current opration , it perform the leading role in canceling the operations
 */
@property (strong, nonatomic) NSString *timeStamp;

@end
