//
//  FileInfo.m
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "FileInfo.h"

@implementation FileInfo

-(instancetype)initWithFileData :(NSData *)fileData havingURL:(NSURL *)fileUrl {
    if(self = [super init]){
        _fileData = fileData;
        _fileUrl = fileUrl;
        //default is NO
        _isCancelled = NO;
        //init with current date and time
        _lastAccess = [NSDate date];
    }
    return self;
}

-(NSData *)getFileData{
    //update the date on every eccess
    [self UpdateAccess];
    return _fileData;
}

-(BOOL) isFileValidForURL:(NSURL *)fileURL{
    //update the date on every eccess
    [self UpdateAccess];
    if ([_fileUrl.absoluteString isEqualToString:fileURL.absoluteString]) {
        return YES;
    }
    else{
        return NO;
    }
}
-(void)UpdateAccess{
    
    _lastAccess = [NSDate date];
}
@end
