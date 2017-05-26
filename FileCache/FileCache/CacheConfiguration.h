//
//  CacheConfiguration.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, CacheType) {
    Memory,
    File,
};


@interface CacheConfiguration : NSObject

@property (nonatomic) double maximumCapacity;
@property (nonatomic) int MaximumNumberOfFiles;
@property (nonatomic) CacheType cacheType;

-(instancetype)initWithDefaultConfiguration;

-(instancetype)initWithCustomeConfigurationWithMaximumMemoryCapacity :(double) maximumCapacityInMB withMaximumNumberOfFiles:(int)maximumFiles withCacheType:(CacheType)theCacheType;
@end
