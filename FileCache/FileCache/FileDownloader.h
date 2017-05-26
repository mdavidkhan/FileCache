//
//  FileDownloader.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloader : NSObject

+ (id) sharedFileDownloader;
-(void)downloadDataFromUrl:(NSURL *)dataURL  timeStamp:(NSString *)timeStamp WithCompletionHandler :(void (^) (NSData * data, NSError * error))completionBlock;
@end
