//
//  FileManager.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FileInfo.h"
#import "CacheManager.h"
#import "FileDownloader.h"

@interface CacheFileManager : NSObject

-(NSString *)getDataFromURL:(NSURL *)dataURL WithCompletionHandler:(void (^)(FileInfo* file, NSError* error))completionBlock;

-(NSString *)getImageFromURL:(NSURL *)imageURL WithCompletionHandler:(void (^)(UIImage * image, NSError* error))completionBlock;

-(void)applyCacheCustomConfiguration :(CacheConfiguration *)configuration;
-(void)cancelDownloadOperationWithTimeStamp :(NSString *)timeStamp;
-(void)removeFileFromCacheUsingURL:(NSURL *) fileURL;
-(void)removeAllObjectFromCache;
-(BOOL)isFileInCacheUsingURL:(NSURL *)fileURL;
@end
