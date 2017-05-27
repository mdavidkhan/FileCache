//
//  CacheFileManagerTests.m
//  FileCache
//
//  Created by Muhammad  Dawood on 27/05/2017.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CacheFileManager.h"

@interface CacheFileManagerTests : XCTestCase
@property (strong,nonatomic) CacheFileManager *cacheManager;
@end

@implementation CacheFileManagerTests

- (void)setUp {
    [super setUp];
    _cacheManager = [[CacheFileManager alloc] init];
}

-(void)testAddingDataTimeStamp{

    NSURL * url = [NSURL URLWithString:@"http://pastebin.com/raw/wgkJgazE"];
    NSString *timeStamp =[_cacheManager getDataFromURL:url WithCompletionHandler:^(FileInfo *file, NSError *error) {}];
    XCTAssertNotNil(timeStamp,"the timeStam is not working anymore");
    
}
-(void)testAddingFileToCache{
    NSURL * url = [NSURL URLWithString:@"http://pastebin.com/raw/wgkJgazE"];
    [_cacheManager getDataFromURL:url WithCompletionHandler:^(FileInfo *file, NSError *error) {
        if (error == nil) {
            XCTAssertTrue([_cacheManager isFileInCacheUsingURL:url],"the file is not saved in cache");
        }
    }];
}

-(void) testAddingImageToCahe{
    
    NSURL * url = [NSURL URLWithString:@"https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=1881cd689e10e5dca28839e68678f432"];
    [_cacheManager getImageFromURL:url WithCompletionHandler:^(UIImage *image, NSError *error) {
        
        if (error == nil) {
            XCTAssertTrue([_cacheManager isFileInCacheUsingURL:url],"the file is not saved in cache");
        }
        
    }];
}

-(void)testAddingImageTimeStamp{
    NSURL * url = [NSURL URLWithString:@"https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=1881cd689e10e5dca28839e68678f432"];
    NSString *timeStamp = [_cacheManager getImageFromURL:url WithCompletionHandler:^(UIImage *image, NSError *error) {}];
    XCTAssertNotNil(timeStamp,"the timeStamp for images is not working anymore");
}

-(void)testRemovingObjectsFromCache{
 
    NSURL * url = [NSURL URLWithString:@"https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=1881cd689e10e5dca28839e68678f432"];
    [_cacheManager getImageFromURL:url WithCompletionHandler:^(UIImage *image, NSError *error) {
        
        if (error == nil && [_cacheManager isFileInCacheUsingURL:url]) {
            //thouh remove file after adding it succefully
            [_cacheManager removeFileFromCacheUsingURL:url];
            XCTAssertFalse([_cacheManager isFileInCacheUsingURL:url],"File has not been deleted yet some issue ocuures");
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
