//
//  FileInfo.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileInfo : NSObject

@property (strong,nonatomic) NSURL * fileUrl;
@property (strong,nonatomic) NSDate* lastAccess;
@property (strong,nonatomic) NSData *fileData;
@property (nonatomic) BOOL isCancelled;

-(instancetype)initWithFileData :(NSData *)fileData havingURL:(NSURL *)fileUrl;

-(NSData *)getFileData;
-(BOOL) isFileValidForURL:(NSURL *)fileURL;
@end


