//
//  Utils.m
//  FileCache
//
//  Created by Muhammad Dawood on 5/26/17.
//  Copyright © 2017 Muhammad Dawood. All rights reserved.
//

#import "Utils.h"
#define kTotalNumberOfBytesPerMB 1000000
@implementation Utils
//
+(double)ConvertMBsToBytes :(double)MBs{
    return MBs*kTotalNumberOfBytesPerMB;
}
+(NSString *)createDownloadDownloadTimeStamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *formatString = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    [formatter setDateFormat:formatString];
    //return string for current date
    return [formatter stringFromDate:[NSDate date]];
}
@end
