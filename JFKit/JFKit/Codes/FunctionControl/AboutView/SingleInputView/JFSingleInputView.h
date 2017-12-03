//
//  JFSingleInputView.h
//  ZXDressingMirror
//
//  Created by hudan on 2017/9/12.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

/**
    单个数字输入视图 (用于输入4位/ 6位验证码等情况)
 */

#import <UIKit/UIKit.h>

// keys 键
#define JFSingleInputBorderColor  @"JFSingleInputBorderColor"            // 边框颜色
#define JFSingleInputTintColor    @"JFSingleInputTintColor"              // 光标颜色
#define JFSingleInputTextColor    @"JFSingleInputTextColor"              // 文字颜色
#define JFSingleInputFontSize     @"JFSingleInputFontSize"               // 文字大小
#define JFSingleInputBorderWidth  @"JFSingleInputBorderWidth"            // 边框宽度
#define JFSingleInputCornerRadius @"JFSingleInputCornerRadius"           // 边框圆角
#define JFSingleInputSize         @"JFSingleInputSize"                   // 文本框大小
#define JFSingleInputMargin       @"JFSingleInputMargin"                 // 输入框间距

typedef void(^JFSingleInputViewFinishBlock)(NSArray *allFieldValues);

@interface JFSingleInputView : UIView

/**
 根据输入框数量进行初始化

 @param number 输入框的数量
 @return 实例化对象
 */
- (instancetype)initWithNumber:(NSInteger)number frame:(CGRect)frame;


/**
 根据输入框的数量和界面配置来初始化

 @param number 输入框的数量
 @param attributes 每个输入框的界面设置
 @return 实例化对象
 */
- (instancetype)initWithNumber:(NSInteger)number attributes:(NSDictionary *)attributes frame:(CGRect)frame;

@property (nonatomic, copy) JFSingleInputViewFinishBlock finishBlock;       // 最后一个输入框编辑完成的 block

@property (nonatomic, assign) BOOL closeFirstFoucsOn;                       // 关闭默认聚焦在第一个输入框 (聚焦在第一个输入框默认开启)

// 自定义 UI
@property (nonatomic, copy) NSDictionary *attributes;                       // 属性的集合

@property (nonatomic, strong) UIColor *fieldBorderColor;                    // 输入框的边框颜色
@property (nonatomic, strong) UIColor *fieldTintColor;                      // 输入框的光标颜色
@property (nonatomic, strong) UIColor *fieldTextColor;                      // 输入框的文字颜色
@property (nonatomic, assign) CGFloat fieldFontSize;                        // 输入框的文字大小
@property (nonatomic, assign) CGFloat fieldBorderWidth;                     // 输入框的边框宽度
@property (nonatomic, assign) CGFloat fieldBorderCornerRadius;              // 输入框的圆角
@property (nonatomic, assign) CGSize fieldSize;                             // 输入框的大小
@property (nonatomic, assign) CGFloat fieldMargin;                          // 输入框间的边距

@end
