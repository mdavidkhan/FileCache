//
//  CacheManager.m
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "CacheManager.h"


@implementation CacheManager

+ (id) sharedCacheManager{
    
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
        [_sharedObject postInitialization];
    });
    
    return _sharedObject;
}
-(void)postInitialization{
    _currentCache = [[NSCache alloc] init];
    [_currentCache setTotalCostLimit:_congiguration.maximumCapacity];
    
}
-(void)clearCache{
    [_currentCache removeAllObjects];
}

@end
