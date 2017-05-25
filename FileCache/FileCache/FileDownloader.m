//
//  FileDownloader.m
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "FileDownloader.h"

#define kMaxConcurrentOperation 10

@interface FileDownloader ()

@property (retain) NSOperationQueue * downloadRequestQueue;


@end
@implementation FileDownloader
+ (id) sharedFileDownloader{
    
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
        [_sharedObject postInitialization];
    });
    
    return _sharedObject;
}
-(void)postInitialization{
    //init the operation queue for the first time
    _downloadRequestQueue = [[NSOperationQueue alloc] init];
}

-(void)downloadDataFromUrl:(NSURL *)dataURL WithCompletionHandler :(void (^) (NSData * data, NSError * error))completionBlock {
    //create an operation to download single file
    NSBlockOperation *downloadOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURLRequest* request = [NSURLRequest requestWithURL:dataURL cachePolicy:0 timeoutInterval:60];
        __block NSError* errorReturned=nil;
        __block NSData *dataReturned;
        dispatch_semaphore_t  sem;
        sem = dispatch_semaphore_create(0);
        [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                             if (data && !error) {
                                                 dataReturned = data;
                                             }
                                             else{
                                                 errorReturned = error;
                                             }
                                             dispatch_semaphore_signal(sem);
                                         }] resume];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        
        //response back
        completionBlock(dataReturned,errorReturned);
        
    }];
    
    
    [_downloadRequestQueue addOperation:downloadOperation];
    
}
@end
