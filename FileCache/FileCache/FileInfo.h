//
//  FileInfo.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 the model class for managing data in cache and this class is building block of cache data , i-e every single object in Cache will be stored as object of this class , this hold basic information of any cached data
 */
@interface FileInfo : NSObject

/**
 this holds the URL of data but this is also used as Key of the data inside the cache
 */
@property (strong,nonatomic) NSURL * fileUrl;


/**
 this is used to keep the last access information of data in form of NSDate, and it is updated every time when we accesses the indormation from this class
 */
@property (strong,nonatomic) NSDate* lastAccess;


/**
 this hold the actual data of file and this is main object of this class
 */
@property (strong,nonatomic) NSData *fileData;


/**
 the Bool used to identify if this class is need to cancel
 */
@property (nonatomic) BOOL isCancelled;



/**
 this is an instance type method used for custom initialization of class with custom data in parameters

 @param fileData the content data of file you want to save
 @param fileUrl the URL of data from which the file has been downloaded
 @return the istance of current class with all data provided in parametes
 */
-(instancetype)initWithFileData :(NSData *)fileData havingURL:(NSURL *)fileUrl;


/**
 this method is used to get the content data of current class and that data will be used as the content of any file user want to save or Use

 @return the data of file which user downloaded
 */
-(NSData *)getFileData;


/**
 this method is used to compare the current cleass url to any URL passed in parameter , this willhelp to identify the object with the help of URL

 @param fileURL the URL of file
 @return return bool if the file url is same as parameter thenit return TRUE else it return FALSE
 */
-(BOOL) isFileValidForURL:(NSURL *)fileURL;
@end


