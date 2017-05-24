//
//  FileManager.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CacheFileManager : NSObject
//+ (id) sharedFileManager;

-(void)getDataFromURL:(NSURL *)dataURL WithCompletionHandler:(void (^)(NSData* data, NSError* error))completionBlock;

-(void)getImageFromURL:(NSURL *)imageURL WithCompletionHandler:(void (^)(UIImage * image, NSError* error))completionBlock;

@end
