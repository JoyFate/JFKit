//
//  StarView.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFStarView.h"
#import "JFDeviceInfo.h"
#import "JFButton.h"

#define kJFStarViewUnSelectStarImageName @"jf_icon_grayStar"
#define kJFStarViewSelectStarImageName @"jf_icon_yellowStar"

@interface JFStarView ()

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) BOOL canClick;

@property (nonatomic, strong) NSArray *starArray;

@end

@implementation JFStarView

- (instancetype)initWithStarNumber:(NSInteger)starNumber
                            height:(CGFloat)height
                            margin:(CGFloat)margin
{
    if (self = [super init]) {
        self.height = height;
        self.margin = margin;
        
        self.seletedImage = kJFStarViewSelectStarImageName;
        self.unSelectedImage = kJFStarViewUnSelectStarImageName;
        
        self.starNumber = starNumber;
        self.canClick = NO;
    }
    return self;
}

#pragma mark - Setter
- (void)setStarNumber:(NSInteger)starNumber
{
    _starNumber = starNumber;
    
    // 移除之前的,重新创建(cell 复用有问题,故改成此做法)
    NSArray *subViews = self.subviews;
    
    if (subViews.count > 0) {
        for (UIView *starButton in subViews) {
            [starButton removeFromSuperview];
        }
    }

    // 没有创建星星
    for (NSInteger index = 0; index < 5; index++) {
        JFButton *starButton = [JFButton make];
        
        [starButton setTag:index];
        [starButton setBackgroundImage:[UIImage imageNamed:self.seletedImage] forState:UIControlStateNormal];
        [starButton setBackgroundImage:[UIImage imageNamed:self.seletedImage] forState:UIControlStateHighlighted];
        [starButton setBackgroundImage:[UIImage imageNamed:self.unSelectedImage] forState:UIControlStateSelected];
        
        [starButton addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat starHeight = self.height;
        CGFloat starWidth  = starHeight * 31/32;
        
        [starButton setFrame:CGRectMake(index * (starWidth + self.margin), 0, starWidth, starHeight)];
        
        [self addSubview:starButton];
        
        if (starNumber == 0) {
            // 为0为一颗星
            if(index > 0) {
                [starButton setSelected:YES];
                [starButton setHidden:!self.canClick];
            }
            else {
                [starButton setSelected:NO];
            }
        }
        
        if (index >= starNumber) {
            [starButton setSelected:YES];
            [starButton setHidden:!self.canClick];
        }
        else {
            [starButton setSelected:NO];
        }
    }
}

- (void)setStarCanClick:(BOOL)starCanClick
{
    _canClick = starCanClick;
    
    NSArray *subViews = self.subviews;
    if (subViews.count > 0) {
        for (UIButton *subView in subViews) {
            [subView setUserInteractionEnabled:starCanClick];
        }
    }
}

- (void)setSeletedImage:(NSString *)seletedImage
{
    _seletedImage = seletedImage;
    
    self.starNumber = self.starNumber;
}

- (void)setUnSelectedImage:(NSString *)unSelectedImage
{
    _unSelectedImage = unSelectedImage;
    
    self.starNumber = self.starNumber;
}

#pragma mark - Star click
- (void)starClick:(UIButton *)sender
{
    NSArray *subViews = self.subviews;
    if (subViews.count > 0) {
        NSInteger sendTag = sender.tag;
        
        for (UIButton *subView in subViews) {
            if (subView.tag > sendTag) {
                [subView setSelected:YES];
            }
            else {
                [subView setSelected:NO];
            }
        }
    }
    
    _starNumber = sender.tag + 1;
}

@end
