//
//  FileManager.m
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "CacheFileManager.h"
#import "CacheManager.h"
#import "FileInfo.h"
#import "FileDownloader.h"

@interface CacheFileManager()

@property (strong,nonatomic) CacheManager *cacheManager;


@end

@implementation CacheFileManager

//+ (id) sharedFileManager{
//    
//    static dispatch_once_t pred = 0;
//    static id _sharedObject = nil;
//    
//    dispatch_once(&pred, ^{
//        _sharedObject = [[self alloc] init];
//        [_sharedObject postInitialization];
//    });
//    
//    return _sharedObject;
//}
-(id)init{
    self = [super init];
    if(self)
    {
        //custome initialization
        _cacheManager = [CacheManager sharedCacheManager];
    }
    return self;
}

#pragma mark File Operation
-(void)getDataFromURL:(NSURL *)dataURL WithCompletionHandler:(void (^)(NSData* data, NSError* error))completionBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //check file in cache
        FileInfo *file = [self getCachedObjectByURL:dataURL];
        //if file is availble
        if (file != nil) {
            //straight return
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock([file getFileData],nil);
            });
            
        }//else download it and save in cache
        else{
            [[FileDownloader sharedFileDownloader] downloadDataFromUrl:dataURL WithCompletionHandler:^(NSData *data, NSError *error) {
                if (error == nil && data !=nil) {
                    //if file is been downloaded in form of data then
                    [self addObjectToCacheWithData:data WithURL:dataURL];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(data,error);
                });
            }];
        }
        
    });
}

-(void)getImageFromURL:(NSURL *)imageURL WithCompletionHandler:(void (^)(UIImage * image, NSError* error))completionBlock{
    //reuse the same method but just change the data to image
  [self getDataFromURL:imageURL WithCompletionHandler:^(NSData *data, NSError *error) {
      UIImage *image;
      if (error == nil && data != nil) {
          image = [UIImage imageWithData:data];
      }
      completionBlock(image,error);
  }];
}

#pragma mark - Cache Operation
-(FileInfo *)getCachedObjectByURL :(NSURL *)fileURL{
    return [_cacheManager.currentCache objectForKey:fileURL.absoluteString];
}
-(void) addObjectToCacheWithData :(NSData *)fileData WithURL:(NSURL *)fileURL{
    //create file model
    FileInfo *file = [[FileInfo alloc] initWithFileData:fileData havingURL:fileURL];
    //save model to cache
    [_cacheManager.currentCache setObject:file forKey:fileURL.absoluteString];
    
}
@end
