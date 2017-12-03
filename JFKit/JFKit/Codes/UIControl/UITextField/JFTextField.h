//
//  JFTextField.h
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JFTextField;

typedef void(^JFTextFieldDeleteBackwardBlock)(JFTextField *textField);

@interface JFTextField : UITextField

@property (nonatomic, assign) CGFloat leftMargin;                                   // 左边距
@property (nonatomic, assign) CGFloat fontSize;                                     // 字体大小
@property (nonatomic, strong) UIColor *placeholderColor;                            // placeholder 的颜色
@property (nonatomic, copy) JFTextFieldDeleteBackwardBlock deleteBackwardBlock;     // 删除按钮点击的 block

@end
