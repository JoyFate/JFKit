//
//  JFTextField.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFTextField.h"

@implementation JFTextField

+ (instancetype)makeWithPlaceholder:(NSString *)placeholder leftMargin:(CGFloat)leftMargin fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor radius:(CGFloat)radius
{
    JFTextField *field = [JFTextField new];
    
    field.placeholder = placeholder;
    field.leftMargin = leftMargin;
    field.fontSize = fontSize;
    field.textColor = fontColor;
    
    if (radius != 0) {
        field.layer.cornerRadius = radius;
        field.layer.masksToBounds = YES;
    }
    
    return field;
}

- (void)setLeftMargin:(CGFloat)leftMargin
{
    UIView *leftView = [[UIView alloc] init];
    [leftView setFrame:CGRectMake(0, 0, leftMargin, 1)];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)deleteBackward
{
    [super deleteBackward];
    
    if (self.deleteBackwardBlock) {
        self.deleteBackwardBlock(self);
    }
}

@end
