//
//  CacheConfiguration.m
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "CacheConfiguration.h"
#import "Utils.h"
@implementation CacheConfiguration


-(instancetype)initWithDefaultConfiguration{
    self = [super init];
    if(self)
    {
        //custome initialization
        //when the maximum capacity is 0 then there will be no limit on memory and we have set it by default we have no limit on data
        _maximumCapacity = 0;
        //when the maximum capacity is 0 then there will be no limit on files and we have set it by default we have no limit on files
        _MaximumNumberOfFiles =0;
    }
    return self;
}

-(instancetype)initWithCustomeConfigurationWithMaximumMemoryCapacityInMBs :(double) maximumCapacityInMB withMaximumNumberOfFiles:(int)maximumFiles withCacheType:(CacheType)theCacheType{
    self = [super init];
    if(self)
    {
        //custome initialization
        //the provded maximum capacity will be applied to configuration
        _maximumCapacity = [Utils ConvertMBsToBytes:maximumCapacityInMB];
        
        //the provded maximum capacity will be applied to configuration
        _MaximumNumberOfFiles = maximumFiles;
        
        //also update the type currently our library is using the memmory so the other type is useless for nowq
        _cacheType = theCacheType;
    }
    return self;
}
@end
