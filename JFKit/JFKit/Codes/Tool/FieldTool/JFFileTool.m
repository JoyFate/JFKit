//
//  JFFileTool.m
//  JFKit
//
//  Created by 胡丹 on 16/8/2.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFFileTool.h"

@implementation JFFileTool

+ (NSString *)getPathWithPathType:(JFFilePathType)type
{
    NSString *path;
    
    switch (type) {
        case JFFilePathType_Document:
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            path = [paths objectAtIndex:0];
        }
            break;
        case JFFilePathType_Cache:
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            path = [paths objectAtIndex:0];
        }
            break;
        case JFFilePathType_Temp:
        default:
        {
            path = NSTemporaryDirectory();
        }
            break;
    }
    
    return path;
}

@end
