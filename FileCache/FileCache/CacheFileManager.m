//
//  FileManager.m
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "CacheFileManager.h"
#import "Utils.h"

@interface CacheFileManager()

@property (strong,nonatomic) CacheManager *cacheManager;


@end

@implementation CacheFileManager


-(id)init{
    self = [super init];
    if(self)
    {
        //custome initialization
        _cacheManager = [CacheManager sharedCacheManager];
    }
    return self;
}

-(void)applyCacheCustomConfiguration :(CacheConfiguration *)configuration{
    //apply custome configuration to cache manager if this is not applied then the default configuration will be loaded
    [_cacheManager applyCustomeConfiguration:configuration];
}

#pragma mark File Operation
-(NSString *)getDataFromURL:(NSURL *)dataURL WithCompletionHandler:(void (^)(FileInfo* file, NSError* error))completionBlock{
    __block NSString *timeStamp =[Utils createDownloadDownloadTimeStamp];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //check file in cache
        FileInfo *file = [self getCachedObjectByURL:dataURL];
        //if file is availble
        if (file != nil) {
            //straight return
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(file,nil);
            });
            
        }//else download it and save in cache
        else{
            [[FileDownloader sharedFileDownloader] downloadDataFromUrl:dataURL timeStamp:timeStamp WithCompletionHandler:^(NSData *data, NSError *error) {
                FileInfo *downloadedFile;
                if (error == nil && data !=nil) {
                    //if file is been downloaded in form of data then
                    downloadedFile = [self addObjectToCacheWithData:data WithURL:dataURL];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(downloadedFile,error);
                });
            }];
        }
        
    });
    return timeStamp;
}
-(void)cancelDownloadOperationWithTimeStamp :(NSString *)timeStamp{
    [[FileDownloader sharedFileDownloader] cancelOperationWithTimeStamp:timeStamp];
}

-(NSString *)getImageFromURL:(NSURL *)imageURL WithCompletionHandler:(void (^)(UIImage * image, NSError* error))completionBlock{
    //reuse the same method but just change the data to image
    NSString *timeStamp = [self getDataFromURL:imageURL WithCompletionHandler:^(FileInfo *file, NSError *error) {
        UIImage *image;
        if (error == nil && file != nil) {
            image = [UIImage imageWithData:[file getFileData]];
        }
        completionBlock(image,error);
    }];
    return timeStamp;
}

#pragma mark - Cache Operation
-(FileInfo *)getCachedObjectByURL :(NSURL *)fileURL{
    return [_cacheManager.currentCache objectForKey:fileURL.absoluteString];
}
-(FileInfo *) addObjectToCacheWithData :(NSData *)fileData WithURL:(NSURL *)fileURL{
    //create file model
    FileInfo *file = [[FileInfo alloc] initWithFileData:fileData havingURL:fileURL];
    //save model to cache
    [_cacheManager.currentCache  setObject:file forKey:fileURL.absoluteString cost:[file getFileData].length];
    
    return file;
    
}
-(void)removeFileFromCacheUsingURL:(NSURL *) fileURL{
    [_cacheManager.currentCache removeObjectForKey:fileURL];
}
-(void)removeAllObjectFromCache{
    [_cacheManager.currentCache removeAllObjects];
}
-(BOOL)isFileInCacheUsingURL:(NSURL *)fileURL{
    if ([self getCachedObjectByURL:fileURL] != nil) {
        return true;
    }
    else{
        return false;
    }
}
@end
