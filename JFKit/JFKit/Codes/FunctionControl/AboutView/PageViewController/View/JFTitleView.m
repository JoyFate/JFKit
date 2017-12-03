//
//  JFTitleView.m
//  JFKit
//
//  Created by 胡丹 on 16/8/25.
//  Copyright © 2016年 胡丹. All rights reserved.
//

#import "JFTitleView.h"

#import "NSString+JF.h"
#import "JFDeviceInfo.h"
#import "JFButton.h"

#define kTitleButtonMargin  fJFScreen(30)
#define kTitleButtonFontSize 16.f

@interface JFTitleView ()

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *buttonArray;

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *currButton;

@property (nonatomic, assign) CGFloat buttonMargin;
@property (nonatomic, assign) CGFloat firstButtonMargin;
@property (nonatomic, assign) CGFloat fontSize;

@end

@implementation JFTitleView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titlesArray
                       images:(NSArray *)imagesArray
                 buttonMargin:(CGFloat)buttonMargin
            firstButtonMargin:(CGFloat)firstMargin
                     fontSize:(CGFloat)fontSize
{
    if (self = [super initWithFrame:frame]) {
        self.titlesArray = titlesArray;
        self.imagesArray = imagesArray;
        self.buttonMargin = buttonMargin;
        self.firstButtonMargin = firstMargin;
        self.fontSize = fontSize;
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.isShowBottomLine = YES;
    
    self.layer.masksToBounds = YES;
    self.showsHorizontalScrollIndicator = NO;
    
    // 将每个title添加入view
    // 左右给15px的边距
    CGFloat x = self.firstButtonMargin < kTitleButtonMargin ?
                kTitleButtonMargin - self.firstButtonMargin : self.firstButtonMargin - kTitleButtonMargin;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titlesArray.count];
    
    if ([self.titlesArray count] > 0) {
        for (NSInteger index = 0; index < self.titlesArray.count; index++) {
            NSString *title = [self.titlesArray objectAtIndex:index];
            
            JFButton *button = [self createButtonWithIndex:index];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            CGSize size = [title sizeForFontsize:self.fontSize];
            button.title = title;

            [button setFrame:CGRectMake(x, 0,
                                        size.width + kTitleButtonMargin*2 , self.frame.size.height)];
            
            button.tag = index;
            
            [tempArray addObject:button];
            [self addSubview:button];
            
            x += button.frame.size.width + self.buttonMargin - kTitleButtonMargin*2;
            
            if (index == 0) {
                self.currButton = button;
                
                // 创建bottomLine
                self.bottomLine = [[UIView alloc] init];
                if (self.bottomLineColor) {
                    [self.bottomLine setBackgroundColor:self.bottomLineColor];
                }
                else {
                    [self.bottomLine setBackgroundColor:[UIColor redColor]];
                }
                CGRect bottomFrame = button.frame;
                bottomFrame.origin.x += fJFScreen(20);
                bottomFrame.origin.y = self.frame.size.height - 1;
                bottomFrame.size.height = 1;
                bottomFrame.size.width -= fJFScreen(20)*2;
                [self.bottomLine setFrame:bottomFrame];
                
                [self addSubview:self.bottomLine];
            }
        }
    }
    
    self.buttonArray = [tempArray copy];
    [self setContentSize:CGSizeMake(x - (self.buttonMargin - self.firstButtonMargin), 0)];
}

- (JFButton *)createButtonWithIndex:(NSInteger)index
{
    JFButton *button = [JFButton make];
    
    button.titleFontSize = self.fontSize;
    button.titleColor = [UIColor blackColor];
    button.titleSelectedColor = [UIColor redColor];
    button.bgColor = button.bgSelectedColor = self.backgroundColor;
    
    // 说明是上图下文字的排版
    if (self.imagesArray.count > 0) {
        button.buttonImageType = JFButtonType_ImageTop;
        button.verImageTitleSpacing = fJFScreen(10);
        button.buttonImage = [self.imagesArray objectAtIndex:index];
        button.buttonSelectedImage = [self.imagesArray objectAtIndex:index + self.titlesArray.count];
    }
    
    return button;
}

- (void)buttonClick:(UIButton *)sender
{
    if ([self.currButton isEqual:sender]) {
        return;
    }
    
    [self moveToButton:sender];
}

- (void)moveToButtonWithIndex:(NSInteger)buttonIndex
{
    UIButton *button = [self.buttonArray objectAtIndex:buttonIndex];
    
    [self moveToButton:button];
}

- (void)moveToButton:(UIButton *)button
{
    CGRect frame = button.frame;
    CGFloat appWidth = kJFAppWidth;
    
    CGPoint offset = self.contentOffset;
    
    if (frame.origin.x + frame.size.width/2 < appWidth/2) {
        // 最左边的几个不需要移动的按钮
        offset = CGPointZero;
    }
    else if (self.contentSize.width <= appWidth)
    {
        // 这种情况任何 title 都不需要移动
    }
    else if (self.contentSize.width - frame.origin.x < appWidth/2 || self.contentSize.width - frame.origin.x - frame.size.width/2 <= appWidth/2) {
        // 最右边的几个不需要移动的按钮
        offset = CGPointMake(self.contentSize.width - appWidth, 0);
    }
    else {
        // 其他可以移动的按钮
        offset = CGPointMake(frame.origin.x + frame.size.width/2 - appWidth/2, 0);
    }
    
    if (self.normalButtonColor) {
        [self.currButton setTitleColor:self.normalButtonColor forState:UIControlStateNormal];
    }
    else {
        [self.currButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    CGRect bottomFrame = self.bottomLine.frame;
    bottomFrame.origin.x = CGRectGetMinX(button.frame) + fJFScreen(9*2);
    bottomFrame.size.width = CGRectGetWidth(button.frame) - fJFScreen(20*2);
    
    
    [UIView animateWithDuration:0.3f animations:^{
        self.currButton = button;
        self.contentOffset = offset;
        
        [self.bottomLine setFrame:bottomFrame];
    }];
    
    // block
    if (self.buttonClickBlock) {
        self.buttonClickBlock(button.tag);
    }
}

- (void)setCurrButton:(UIButton *)currButton
{
    _currButton.selected = NO;
    currButton.selected = YES;
    
    _currButton = currButton;
}

#pragma mark - Setter
- (void)setSelectButtonColor:(UIColor *)selectButtonColor
{
    _selectButtonColor = selectButtonColor;
    
    if ([self.buttonArray count] > 0) {
        for (JFButton *button in self.buttonArray) {
            button.titleSelectedColor = selectButtonColor;
        }
    }
}

- (void)setNormalButtonColor:(UIColor *)normalButtonColor
{
    _normalButtonColor = normalButtonColor;
    
    if ([self.buttonArray count] > 0) {
        for (JFButton *button in self.buttonArray) {
            button.titleColor = normalButtonColor;
        }
    }
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor
{
    _bottomLineColor = bottomLineColor;
    
    [self.bottomLine setBackgroundColor:_bottomLineColor];
}

- (void)setIsShowBottomLine:(BOOL)isShowBottomLine
{
    _isShowBottomLine = isShowBottomLine;
    
    [self.bottomLine setHidden:!isShowBottomLine];
}

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight
{
    CGRect lineRect = self.bottomLine.frame;
    
    [self.bottomLine removeFromSuperview];
    
    UIView *newBottomLine = [[UIView alloc] init];
    [newBottomLine setBackgroundColor:self.bottomLine.backgroundColor];
    
    CGFloat sub = bottomLineHeight - lineRect.size.height;
    
    if (sub > 0) {
        lineRect.origin.y = lineRect.origin.y - sub;
    }
    else {
        lineRect.origin.y = lineRect.origin.y + sub;
    }
    lineRect.size.height = bottomLineHeight;
    
    [newBottomLine setFrame:lineRect];
    
    self.bottomLine = newBottomLine;
    [self addSubview:self.bottomLine];
}

@end
