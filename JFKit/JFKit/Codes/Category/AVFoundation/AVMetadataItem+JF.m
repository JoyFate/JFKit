//
//  AVMetadataItem+JF.m
//  JFKit
//
//  Created by 胡丹 on 2017/3/6.
//  Copyright © 2017年 胡丹. All rights reserved.
//

#import "AVMetadataItem+JF.h"

@implementation AVMetadataItem (JF)

- (NSString *)keyString
{
    if ([self.key isKindOfClass:[NSString class]]) {
        return (NSString *)self.key;
    }
    else {
        UInt32 keyValue = [(NSNumber *)self.key unsignedIntValue];
        
        // 大部分是4个字符代码,但不一定都是，需要判断
        size_t lenght = sizeof(UInt32);
        if ((keyValue >> 24) == 0) {
            --lenght;
        }
        if ((keyValue >> 16) == 0) {
            --lenght;
        }
        if ((keyValue >> 8) == 0) {
            --lenght;
        }
        if ((keyValue >> 0) == 0) {
            --lenght;
        }
        
        long address = (unsigned long)&keyValue;
        address += (sizeof(UInt32) - lenght);
        
        // 由于数字是big endian格式，将其转换为符合主CPU的顺序的little endian格式（Intel和ARM处理器都是这样要求的）
        keyValue = CFSwapInt32BigToHost(keyValue);
        
        char cstring[lenght];
        strncpy(cstring, (char *)address, lenght);
        cstring[lenght] = '\0';
        
        // 替换
        if (cstring[0] == '\xA9') {
            cstring[0] = '@';
            
            return [NSString stringWithCString:(char *)cstring encoding:NSUTF8StringEncoding];
        }
        else {
            return @"<<unknown>>";
        }
    }
}

@end
