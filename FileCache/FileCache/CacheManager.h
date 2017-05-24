//
//  CacheManager.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheConfiguration.h"

@interface CacheManager : NSObject

@property (strong, nonatomic) CacheConfiguration * congiguration;
@property (strong,nonatomic) NSCache *currentCache;
-(void)clearCache;
+(id)sharedCacheManager;

@end
