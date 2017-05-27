//
//  FileDownloader.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 this class is used to manage the downloading of any data which will be saved in Cache this is singelton class and its instance will be ingle all oevr the app session
 */
@interface FileDownloader : NSObject


/**
 this method used to get the Singelton instance of the current class
 
 @return the singleton instance of the class
 */
+ (id) sharedFileDownloader;


/**
 this method us used to download the data from the provided URL respond with the completion block, this method download the data in queue you can call this method parallel and it will operate every call through an Operation Queue
 
 @param dataURL the URL of source file to be downloade
 @param timeStamp the TimeStamp which is given to the session and this will be used to cancel this downloading operation
 @param completionBlock the completion block is initiated when any download is completed or failed
 */
-(void)downloadDataFromUrl:(NSURL *)dataURL  timeStamp:(NSString *)timeStamp WithCompletionHandler :(void (^) (NSData * data, NSError * error))completionBlock;


/**
 this method is used to cancel any ongoing download operation, if the operation is in progress it will cancel it and it will never cancel any completed operation
 @Warnning this method is using TimeStamp will providedby file manager else it will ignore any other information
 
 @param timeStamp the TimeStamp Ehich is returned from the "getDataFromURL" method
 */
-(void)cancelOperationWithTimeStamp :(NSString *)timeStamp;
@end
