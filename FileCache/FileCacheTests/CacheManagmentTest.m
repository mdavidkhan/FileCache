//
//  CacheManagmentTest.m
//  FileCache
//
//  Created by Muhammad  Dawood on 27/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CacheManager.h"
#import "CacheConfiguration.h"
#import "CacheFileManager.h"
#import "Utils.h"

@interface CacheManagmentTest : XCTestCase

@property (nonatomic,strong) CacheManager *manager;
@end

@implementation CacheManagmentTest

- (void)setUp {
    [super setUp];
    //shared init
    _manager = [CacheManager sharedCacheManager];
    
}
//MARK: after initialization tests

-(void)testTheDefaultConfigurationIsLoadedOrNot{
    XCTAssertNotNil(_manager.configuration,"The Default configuration are not loaded tho :P");
}

-(void)testTheDefaultConfigurationValues{
    
    XCTAssertTrue(_manager.configuration.maximumCapacity >= 0,"The default configuration for max storage are not set propely");

    XCTAssertTrue(_manager.configuration.MaximumNumberOfFiles >= 0,"the default configuration for max files are not set properly");
    
    XCTAssertEqual(_manager.configuration.cacheType, 0,"the memory type is not initilaized as required, although this functionlity is not much fuctional but this is for future work ");
}

-(void)testTheCustomConfigurationApplyingOnCache{
    
    CacheConfiguration *customeConfiguration = [[CacheConfiguration alloc] initWithCustomeConfigurationWithMaximumMemoryCapacityInMBs:100 withMaximumNumberOfFiles:150 withCacheType:0];
    
    [_manager applyCustomeConfiguration:customeConfiguration];
    
    XCTAssertEqual(_manager.currentCache.totalCostLimit, [Utils ConvertMBsToBytes:100],"the max capacity value is not applying to cahce ");
    XCTAssertEqual(_manager.currentCache.countLimit, 150,"the max number of files value is not apply to the Cache");
    
}

-(void)testClearCacheMethod{
    NSURL * url = [NSURL URLWithString:@"https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=1881cd689e10e5dca28839e68678f432"];
    CacheFileManager *fileManagerOfCache = [[CacheFileManager alloc] init];
    [fileManagerOfCache getDataFromURL:url WithCompletionHandler:^(FileInfo *file, NSError *error) {
        if (error ==nil && [fileManagerOfCache isFileInCacheUsingURL:url]) {
            //now remove all items after successfully loading file
            [_manager clearCache];
            XCTAssertNil([_manager.currentCache objectForKey:url.absoluteString],"the File is not removed from the cahe");
        }
    }];
   
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
