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

/**
 This is main class for library by whcich the user will interacted and all operations related to files are performed here 
 i-e this will manager the file Insertion into cache, Downloading , removing of cached files and geting of cache files  etc
 THis will also help to apply the custom configuration to cache managment
 
 */
@interface CacheFileManager : NSObject

/**
 this method is used to download the required data thorugh URL and then save it to the cache. 
 If any request with that same URL come again it will provide the cached file without downloading it again until unliss the file has been evicted from cache

 @param dataURL the Source URL of required data , it will always be the URL not the String
 @param completionBlock the final block which will fire after completing of operation as well ass it will calls if any error stops the operation. this Block is contains two parameters on ths "File" and another is "Error", ----- "File": is the model class which contains all the information agains the downloaded file. if you want to get the actual data for using it you can call the method named "getFileData" it will give you the exact data of the required file -----"error": this is gerneral Error class which will contains the information about any error occures while loading the file
 
 @return the return value is string which known as "Time Stamp", it is used to identify the the download operation of any data. this will help also to cancel any ongoing operation of downloading i-e simply save the time stamp then passes that to another method "cancelDownloadOperationWithTimeStamp:".
 */


-(NSString *)getDataFromURL:(NSURL *)dataURL WithCompletionHandler:(void (^)(FileInfo* file, NSError* error))completionBlock;

/**
 Thhis method is used to download the required Image thorugh URL and then save it to the cache.
 If any request with that same URL come again it will provide the cached Image without downloading it again until unliss the file has been evicted from cache

 @param imageURL the Source URL of required Image , it will always be the URL not the String
 
 @param completionBlock the final block which will fire after completing of operation as well ass it will calls if any error stops the operation. this Block is contains two parameters on ths "Image" and another is "Error",------"Image": is the image  downloaded.-------"error": this is gerneral Error class which will contains the information about any error occures while loading the Image
 
 @return the return value is string which known as "Time Stamp", it is used to identify the the download operation of any data. this will help also to cancel any ongoing operation of downloading i-e simply save the time stamp then passes that to another method "cancelDownloadOperationWithTimeStamp:".
 */
-(NSString *)getImageFromURL:(NSURL *)imageURL WithCompletionHandler:(void (^)(UIImage * image, NSError* error))completionBlock;


/**
 this method is used to apply any custome configuration to the current cache managment 
 @Warnning this method need proprly designed "CacheConfiguration" model so before apply anychages first check documentation of aurgument.
 
 @param configuration this is model class which will be created with custome data i-e MAX Storrage ,MAX number of Files  and Storage type
 */
-(void)applyCacheCustomConfiguration :(CacheConfiguration *)configuration;


/**
 this method is used to cancel any ongoing download operation, if the operation is in progress it will cancel it and it will never cancel any completed operation
 @Warnning this method is using TimeStamp will returned from the "getDataFromURL" method else it will ignore any other information
 
 @param timeStamp the TimeStamp Ehich is returned from the "getDataFromURL" method
 */
-(void)cancelDownloadOperationWithTimeStamp :(NSString *)timeStamp;


/**
 this method will remove the any file from Cache by simply providing there url and it will be Avicted instantly

 @param fileURL the `URL` of File you want to remove from cache
 */
-(void)removeFileFromCacheUsingURL:(NSURL *) fileURL;


/**
 this method is used to clean the current cache and delete all the information inside the cache
 */
-(void)removeAllObjectFromCache;


/**
 this method is used to check if any file accosiated with provided URL is present in Cache or not

 @param fileURL the URL of file which you want to check if it exist or not
 @return return a bool value which will identify that the file is exist or not , if it returns TRUE then file is exist if it returns FALSE then file is not exist in cache
 */
-(BOOL)isFileInCacheUsingURL:(NSURL *)fileURL;
@end
