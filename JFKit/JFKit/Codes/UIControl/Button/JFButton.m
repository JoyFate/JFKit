//
//  JFButton.m
//  JFKit
//
//  Created by hudan on 16/9/5.
//  Copyright © 2016年 胡丹. All rights reserved.
//

#import "JFButton.h"
@interface JFButton ()
{
    UIColor *_titleSelectedColor;
}

@end

@implementation JFButton

- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonClick
{
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}

+ (instancetype)make
{
    return [[JFButton alloc] init];
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - OverWrite
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.buttonImageType == JFButtonType_ImageTop) {
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalHeight = (imageSize.height + titleSize.height + self.verImageTitleSpacing);
        self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    }
    else if (self.buttonImageType == JFButtonType_ImageRight) {
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
        CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width;
        }
        CGFloat totalWidth = (imageSize.width + titleSize.width + self.horImageTitleSpacing);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0.0,  - (totalWidth - imageSize.width));
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -(totalWidth - titleSize.width), 0, imageSize.width);
    }
}

#pragma mark - Setter
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (self.isSelected) {
        [self setBackgroundColor:self.bgSelectedColor];
        [self setTitle:self.titleSelected.length > 0 ? self.titleSelected : self.title forState:UIControlStateNormal];
    }
    else {
        [self setBackgroundColor:self.bgColor];
        [self setTitle:self.title forState:UIControlStateNormal];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    // 重新设定了 title 后需要调用 drawRect 重绘
    [self setNeedsDisplay];
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    
    [self setBackgroundColor:bgColor];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setTitleHightColor:(UIColor *)titleHightColor
{
    _titleHightColor = titleHightColor;
    
    [self setTitleColor:titleHightColor forState:UIControlStateHighlighted];
}

- (void)setTitleFontSize:(CGFloat)titleFontSize
{
    _titleFontSize = titleFontSize;
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:titleFontSize]];
}

- (void)setButtonImage:(UIImage *)buttonImage
{
    _buttonImage = buttonImage;
    
    [self setImage:buttonImage forState:UIControlStateNormal];
}
- (void)setButtonSelectedImage:(UIImage *)buttonSelectedImage
{
    _buttonSelectedImage = buttonSelectedImage;
    [self setImage:buttonSelectedImage forState:UIControlStateSelected];
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    _titleSelectedColor = titleSelectedColor;
    
    [self setTitleColor:titleSelectedColor forState:UIControlStateSelected];
}


#pragma mark - Getter

- (UIColor *)bgSelectedColor
{
    if (!_bgSelectedColor) {
        if (self.bgColor) {
            _bgSelectedColor = self.bgColor;
        }
        else {
            _bgSelectedColor = [UIColor whiteColor];
        }
    }
    return _bgSelectedColor;
}

- (UIColor *)titleSelectedColor
{
    if (!_titleSelectedColor) {
        if (self.titleColor) {
            _titleSelectedColor = self.titleColor;
        }
        else {
            _titleSelectedColor = [UIColor blackColor];
        }
    }
    return _titleSelectedColor;
}
@end