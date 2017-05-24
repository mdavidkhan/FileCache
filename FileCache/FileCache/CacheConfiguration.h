//
//  CacheConfiguration.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheConfiguration : NSObject

@property (nonatomic) double maximumCapacity;
@property (nonatomic) int MaximumNumberOfFiles;
@property (strong,nonatomic) NSString *cacheType;

-(instancetype)initWithDefaultConfiguration;


@end
