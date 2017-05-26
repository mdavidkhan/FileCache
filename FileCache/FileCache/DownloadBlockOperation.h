//
//  DownloadBlockOperation.h
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadBlockOperation : NSBlockOperation

@property (strong, nonatomic) NSString *timeStamp;

@end
