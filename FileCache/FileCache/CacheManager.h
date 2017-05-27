//
//  CacheManager.h
//  FileCache
//
//  Created by Muhammad  Dawood on 24/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheConfiguration.h"


/**
 the Backbone of Cache , this class holds the cache object as well as the helping methods to manage the cache, the instance of this class will be the same all over the system due to its singelton behaviour
 */
@interface CacheManager : NSObject<NSCacheDelegate>


/**
 thie property holds all the configuration that will apply to the cache object
 */
@property (strong, nonatomic) CacheConfiguration * configuration;


/**
 main object of cahe all over the app session , this will used to hold all the information as cache
 */
@property (strong,nonatomic) NSCache *currentCache;


/**
 this method is used to apply the cleaning of objects on "CurrentCache" property
 */
-(void)clearCache;


/**
 this method used to get the Singelton instance of the current class

 @return the singleton instance of the class
 */
+(id)sharedCacheManager;


/**
 this method is used to apply the configuration on cache object

 @param configuration the custome configuration whci are created by you
 */
-(void)applyCustomeConfiguration :(CacheConfiguration *)configuration;
@end
