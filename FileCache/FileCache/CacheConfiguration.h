//
//  CacheConfiguration.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @typedef CacheType
 * @brief A list of types of cahe modes.
 * @Warnning (current system have only support of Memeory Type cache)
 * @constant Memory A type of cahe which will use only the memory of device
 * @constant File A type of cache which will us the file mecahenism and store the cahe as physical files (it is not supported in current system)
 */
typedef NS_ENUM(NSUInteger, CacheType) {
    Memory = 1,
    File = 2,
};


/**
 this is model class which is used as the basic configuration of the cahe we used in our system , this class hods the basic settings option for cache and some helping methods
 */
@interface CacheConfiguration : NSObject

/*!
 * @brief double value which holds the MAX storage capacity of cache in Mega Bytes unit. By default it will be 0
 */
@property (nonatomic) double maximumCapacity;


/*!
 * @brief The integer value which holds the informations MAX number of files capacity in cache by default it will be 0
 */
@property (nonatomic) int MaximumNumberOfFiles;

/*!
 * @brief The ENUM which holds the type of cahe modes
 */
@property (nonatomic) CacheType cacheType;


/**
 this is instance initialization method with loading of defaults values

 @return the instance of current classs
 */
-(instancetype)initWithDefaultConfiguration;

/**
 this is instance initialization method with loading of custome values

 @param maximumCapacityInMB MAX storage capacity of cache in Mega Bytes unit.
 @param maximumFiles  MAX number of files capacity in cache
 @param theCacheType The ENUM which holds the type of cahe modes
 @return the instance of current classs
 */
-(instancetype)initWithCustomeConfigurationWithMaximumMemoryCapacityInMBs :(double) maximumCapacityInMB withMaximumNumberOfFiles:(int)maximumFiles withCacheType:(CacheType)theCacheType;
@end
