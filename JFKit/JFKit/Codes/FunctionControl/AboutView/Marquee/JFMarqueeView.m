//
//  JFMarqueeView.m
//  StockOffLine-dev
//
//  Created by MAC on 2018/1/11.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "JFMarqueeView.h"
#import "JFButton.h"
#import "NSArray+JF.h"
#import "JFCommHeader.h"

@interface JFMarqueeView ()

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *currLabel;
@property (nonatomic, strong) JFButton *button;

@property (nonatomic, assign) NSInteger currIndex;
@property (nonatomic, assign) NSTimeInterval duriection;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat height;

@end

@implementation JFMarqueeView

- (instancetype)initWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor durection:(NSTimeInterval)duriection clickBlock:(void (^)(JFMarqueeModel *))clickBlock
{
    if (self = [super init]) {
        [self initUIWithFontSize:fontSize textColor:textColor];
        self.duriection = duriection;
        self.clickBlock = clickBlock;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initUIWithFontSize:15.f textColor:[UIColor blackColor]];
        self.duriection = 2.f;
    }
    return self;
}

- (void)start
{
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duriection target:self selector:@selector(doAnimate) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)initUIWithFontSize:(CGFloat)fontSize textColor:(UIColor *)color
{
    self.layer.masksToBounds = YES;
    
    UILabel *label1 = [UILabel new];
    label1.font = kJFFontSyetem(fontSize);
    label1.textColor = color;
    [self addSubview:label1];

    self.firstLabel = label1;
    self.currLabel = label1;
    
    UILabel *label2 = [UILabel new];
    label2.font = kJFFontSyetem(fontSize);
    label2.textColor = color;
    [self addSubview:label2];
    
    self.secondLabel = label2;
    
    JFButton *btn = [JFButton make];
    [btn addTarget:self action:@selector(Click)];
    [self addSubview:btn];
    self.button = btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = self.frame.size.height;
    
    self.firstLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.height);
    
    self.secondLabel.frame = CGRectMake(0, self.height, self.frame.size.width, self.height);
    
    self.button.frame = self.bounds;
}

#pragma mark - Button Click
- (void)Click
{
    if (self.clickBlock) {
        self.clickBlock((JFMarqueeModel *)[self.dataArray objectAtIndex:self.currIndex]);
    }
}

#pragma mark - Timer
- (void)doAnimate
{
    NSInteger nextIndex = self.currIndex + 1;
    UILabel *nextLabel = self.currLabel == self.firstLabel ? self.secondLabel : self.firstLabel;
    
    if (nextIndex <= self.dataArray.count - 1) {
        self.currIndex = nextIndex;
    }
    else if (nextIndex == self.dataArray.count) {
        nextIndex = 0;
    }
    
    self.currIndex = nextIndex;
    
    nextLabel.text = ((JFMarqueeModel *)[self.dataArray objectAtIndexSafe:self.currIndex]).title;

    // 动画
    [UIView animateWithDuration:0.8f animations:^{
        CGRect currFrame = self.currLabel.frame;
        currFrame.origin.y = -self.height;
        self.currLabel.frame = currFrame;
        
        CGRect nextFrame = nextLabel.frame;
        nextFrame.origin.y = 0;
        nextLabel.frame = nextFrame;
        
    } completion:^(BOOL finished) {
        self.currLabel = nextLabel;
        
        UILabel *btmLabel = nextLabel == self.firstLabel ? self.secondLabel : self.firstLabel;
        CGRect frame = btmLabel.frame;
        frame.origin.y = self.height;
        btmLabel.frame = frame;
        
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(doAnimate) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }];
}

#pragma mark - Setter
- (void)setDataArray:(NSArray<JFMarqueeModel *> *)dataArray
{
    _dataArray = dataArray;
    
    self.currIndex = 0;
    
    if (dataArray.count > 0) {
        
        self.firstLabel.text = ((JFMarqueeModel *)[dataArray objectAtIndexSafe:0]).title;

        if (dataArray.count > 1) {
            
            self.secondLabel.text = ((JFMarqueeModel *)[dataArray objectAtIndexSafe:1]).title;
        }
    }
}

@end
