//
//  ToolSingleton.m
//  JFKit
//
//  Created by 胡丹 on 16/8/2.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "ToolSingleton.h"

@implementation ToolSingleton

SingletonM(ToolSingleton)

#pragma mark - Getter
- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;

}

- (NSString *)dateTimeToYYYY_MM_HH_SS:(NSString *)timeString
{
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [self.dateFormatter stringFromDate:date];
    return dateString;
}

@end
