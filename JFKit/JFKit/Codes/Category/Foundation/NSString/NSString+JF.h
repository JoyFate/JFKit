//
//  NSString+JF.h
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (JF)

/**
 *  计算当前string的宽度
 *
 *  @param fontsize 显示的字体大小
 *
 *  @return 计算后的大小
 */
- (CGSize)sizeForFontsize:(CGFloat)fontsize;

/**
 *  计算当前string的高度
 *
 *  @return 计算后的大小
 */
- (CGSize)textHeightWithTextWidth:(CGFloat)width withFontsize:(CGFloat)fontsize;


/**
 遍历字符串的每一个字符,并通过 block 返回

 @param block 当前字符的索引, 当前字符
 */
- (void)enumerateEachChar:(void(^)(NSInteger index, NSString *singleChar))block;


/**
 将 json 字符串转成字典

 @param jsonString json 字符串
 @return 字典
 */
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;

@end
