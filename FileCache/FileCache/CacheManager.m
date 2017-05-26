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
    _congiguration = [[CacheConfiguration alloc] initWithDefaultConfiguration];
    //here I just reuse the same method for default configuration also
    [self applyCustomeConfiguration:_congiguration];
    
}
-(void)clearCache{
    [_currentCache removeAllObjects];
}
-(void)applyCustomeConfiguration :(CacheConfiguration *)configuration{
    
    _congiguration = configuration;
    [_currentCache setTotalCostLimit:_congiguration.maximumCapacity];
    [_currentCache setCountLimit:_congiguration.MaximumNumberOfFiles];
    [_currentCache setDelegate:self];
    [_currentCache setEvictsObjectsWithDiscardedContent:YES];
    
}
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"the object %@ is evicted ",obj);
}
@end
