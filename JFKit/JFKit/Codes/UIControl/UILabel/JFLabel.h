//
//  JFLabel.h
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFLabel : UILabel

// 两个属性相互影响, 后一个设置的会影响最终字体
@property (nonatomic, assign) CGFloat fontSize;                 // 文字大小
@property (nonatomic, assign) CGFloat blodFontSize;             // 粗体文字大小

@property (nonatomic, assign) CGFloat lineSpace;                // 行间距
@property (nonatomic, assign, readonly) CGFloat textHeight;     // 文字高度
@property (nonatomic, assign) CGFloat width;                    // 宽度，用于计算文字高度，若不设置，默认为app宽度

// 增加属性
- (void)addAttribute:(NSDictionary *)attribute range:(NSRange)range;

+ (instancetype)makeText:(NSString *)text fontColor:(UIColor *)color fontSize:(CGFloat)fontSize;

@end
