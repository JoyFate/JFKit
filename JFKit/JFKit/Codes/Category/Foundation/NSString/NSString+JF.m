//
//  NSString+JF.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "NSString+JF.h"

@implementation NSString (JF)

- (CGSize)sizeForFontsize:(CGFloat)fontsize {
    CGRect titleRect = [self boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontsize]}
                                           context:nil];
    
    return CGSizeMake(titleRect.size.width,
                      titleRect.size.height);
}

- (CGSize)textHeightWithTextWidth:(CGFloat)width withFontsize:(CGFloat)fontsize  {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
    
    CGSize size = rect.size;
    
    return size;
}

- (void)enumerateEachChar:(void (^)(NSInteger, NSString *))block
{
    if (self.length > 0) {
        
        NSString *temp = nil;
        
        for(int i =0; i < [self length]; i++) {
            
            temp = [self substringWithRange:NSMakeRange(i, 1)];
            
            if (block) {
                block(i, temp);
            }
        }
    }
}

+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"JSON解析失败：%@",err);
        
        return nil;
        
    }
    return dic;
}

@end
