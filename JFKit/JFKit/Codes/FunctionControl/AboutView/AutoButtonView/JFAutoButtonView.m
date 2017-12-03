//
//  JFAutoButtonView.m
//  JFKit
//
//  Created by hudan on 16/9/27.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFAutoButtonView.h"
#import "NSString+JF.h"
#import "JFButton.h"

typedef void(^ClickBlock)(NSString *title);

@interface JFAutoButtonView ()

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleColorHeightlight;
@property (nonatomic, strong) UIColor *titleSelectColor;
@property (nonatomic, strong) UIColor *buttonBgColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat corner;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat buttonMargin;
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) BOOL hasBorder;

@property (nonatomic, strong) NSArray *heightlightTitles;

@property (nonatomic, strong) JFButton *currButton;

@property (nonatomic, copy) ClickBlock clickBlock;

@end

@implementation JFAutoButtonView

- (instancetype)initWithFrame:(CGRect)frame
                 buttonTitles:(NSArray *)titles
            buttonTitleHeight:(NSArray *)heightlightTitles
          attributeDictionary:(NSDictionary *)attribute
                   clickBlock:(void(^)(NSString *))clickBlock
{
    if (self = [super initWithFrame:frame]) {
        
        [self setPropertyWithDict:attribute];
        
        self.clickBlock = clickBlock;
        self.heightlightTitles = heightlightTitles;
        
        CGFloat x = self.buttonMargin;
        CGFloat y = self.buttonMargin;
        
        for (NSString *title in titles) {
            
            JFButton *button = [self createButtonWithTitle:title];
            
            CGRect buttonFrame = button.frame;
            
            if (x + buttonFrame.size.width - self.buttonMargin > self.frame.size.width) {
                // 换行
                y += buttonFrame.size.height + self.buttonMargin;
                x = self.buttonMargin;
            }
            
            buttonFrame.origin.x = x;
            buttonFrame.origin.y = y;
            
            [button setFrame:buttonFrame];
            
            [self addSubview:button];
            
            x += buttonFrame.size.width + self.buttonMargin;
        }
    }
    return self;
}

// 创建 button
- (JFButton *)createButtonWithTitle:(NSString *)title
{
    JFButton *button = [JFButton make];
    
    button.titleFontSize = self.fontSize;
    button.title = title;
    button.titleColor = self.titleColor;
    button.titleSelectedColor = self.titleSelectColor;
    button.bgColor = self.buttonBgColor;
    
    if (self.hasBorder) {
        [button.layer setBorderWidth:1.f];
        [button.layer setBorderColor:self.borderColor.CGColor];
    }
    
    [button.layer setCornerRadius:self.corner];
    // 设置突出文字
    if ([self.heightlightTitles containsObject:title]) {
        button.titleColor = self.titleColorHeightlight;
    }
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGSize textSize = [title sizeForFontsize:15.f];
    [button setFrame:CGRectMake(0, 0, textSize.width + 6, self.buttonHeight)];
    
    if (!self.currButton) {
        self.currButton = button;
    }
    
    return button;
}

- (void)buttonClick:(JFButton *)sender
{
    if (![self.currButton isEqual:sender]) {
        self.currButton.selected = NO;
        sender.selected = YES;
        self.currButton = sender;
    }
    
    if (self.clickBlock) {
        self.clickBlock(sender.title);
    }
}

// 设置属性
- (void)setPropertyWithDict:(NSDictionary *)attribute
{
    if ((self.fontSize = [[attribute objectForKey:JFAutoButtonViewFontSizeKey] floatValue]) == 0) {
        self.fontSize = 15.f;
    }
    if (!(self.titleColor = [attribute objectForKey:JFAutoButtonViewTitleColorKey])) {
        self.titleColor = [UIColor blackColor];
    }
    if (!(self.titleSelectColor = [attribute objectForKey:JFAutoButtonViewTitleSelectColorKey])) {
        self.titleSelectColor = [UIColor blackColor];
    }
    if (!(self.titleColorHeightlight = [attribute objectForKey:JFAutoButtonViewTitleColorHeightLightKey])) {
        self.titleColorHeightlight = [UIColor blackColor];
    }
    if ((self.corner = [[attribute objectForKey:JFAutoButtonViewCornerKey] floatValue]) == 0) {
        self.corner = 10.f;
    }
    if ((self.buttonMargin = [[attribute objectForKey:JFAutoButtonViewButtonMarginKey] floatValue]) == 0) {
        self.buttonMargin = 10.f;
    }
    if (!(self.borderColor = [attribute objectForKey:JFAutoButtonViewBorderColorKey])) {
        self.borderColor = [UIColor blackColor];
    }
    if ((self.buttonHeight = [[attribute objectForKey:JFAutoButtonViewButtonHeightKey] floatValue]) == 0) {
        self.buttonHeight = 30.f;
    }
    if (!(self.buttonBgColor = [attribute objectForKey:JFAutoButtonViewButtonBgColor])) {
        self.buttonBgColor = [UIColor whiteColor];
    }
    
    self.hasBorder = [[attribute objectForKey:JFAutoButtonViewBorderHide] boolValue];
}


@end
