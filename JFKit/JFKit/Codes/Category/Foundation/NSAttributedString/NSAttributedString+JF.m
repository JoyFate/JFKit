//
//  NSAttributedString+JF.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "NSAttributedString+JF.h"

@implementation NSAttributedString (JF)

+ (NSAttributedString *)getAttributeString:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    // 防止传入 nil 对象导致崩溃
    if (text.length == 0) {
        text = @"";
    }
    
    NSMutableAttributedString *attributeAtring =[[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributeAtring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributeAtring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.f] range:NSMakeRange(0, [text length])];
    
    return attributeAtring;
}

@end
