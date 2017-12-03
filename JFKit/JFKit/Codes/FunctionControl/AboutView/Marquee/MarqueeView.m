//
//  MarqueeView.m
//  JFKit
//
//  Created by joyFate on 2017/3/14.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "MarqueeView.h"

#import "JFColor.h"
#import "JFDeviceInfo.h"

@interface MarqueeView ()

// 创建两个label循环滚动
@property (nonatomic, strong) UILabel *firstContentLabel;
@property (nonatomic, strong) UILabel *secondContentLabel;

// 记录
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MarqueeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupView];
    }
    return self;
}


-(void)setupView {
    self.firstContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
    [self.firstContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.firstContentLabel setNumberOfLines:1];
    self.firstContentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecongnizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer1.numberOfTapsRequired = 1;
    [self.firstContentLabel addGestureRecognizer:tapGesturRecongnizer1];
    
    self.firstContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.firstContentLabel setTextColor:HexColor(0xff9900)];
    self.firstContentLabel.font=[UIFont boldSystemFontOfSize:fJFFontSize(26)];
    
    self.secondContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height , self.frame.size.width - 20, self.frame.size.height)];
    [self.secondContentLabel setBackgroundColor:[UIColor clearColor]];
    [self.secondContentLabel setTextColor:HexColor(0xff9900)];
    self.secondContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.secondContentLabel setNumberOfLines:1];
    self.secondContentLabel.userInteractionEnabled = YES;
    self.secondContentLabel.font=[UIFont boldSystemFontOfSize:fJFFontSize(26)];
    
    UITapGestureRecognizer *tapGesturRecongnizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer2.numberOfTapsRequired = 1;
    [self.secondContentLabel addGestureRecognizer:tapGesturRecongnizer2];
    
    [self addSubview:self.firstContentLabel];
    [self addSubview:self.secondContentLabel];
    
    // 默认初始方向是向上
    self.Direction = MarqueeViewDirectionDown;
    self.marqueeAnimationDuration = 1;
    self.clipsToBounds = YES;
}



-(void)startVerticalLoopAnimation{
    
    self.firstContentLabel.text = ((MarqueeModel *)[self.marqueeArray objectAtIndex:self.currentIndex]).text;
    
    float firstContentLaStartY = 0;
    float firstContentLaEndY = 0;
    float secondContentLaStartY = 0;
    float secondContentLaEndY = 0;
    
    NSInteger secondCurrentIndex  = self.currentIndex + 1;
    if (secondCurrentIndex > self.marqueeArray.count - 1) {
        secondCurrentIndex = 0;
    }
    
    switch (self.Direction) {
        case MarqueeViewDirectionBottom:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY - self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY - self.frame.size.height;
            
            break;
        case MarqueeViewDirectionDown:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = -self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY + self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY + self.frame.size.height;
            
            break;
        default:
            break;
    }
    
    self.secondContentLabel.text = ((MarqueeModel *)[self.marqueeArray objectAtIndex:secondCurrentIndex]).text;
    
    self.firstContentLabel.frame = CGRectMake(10, firstContentLaStartY, self.frame.size.width - 20, self.frame.size.height);
    self.secondContentLabel.frame = CGRectMake(10, secondContentLaStartY, self.frame.size.width - 20, self.frame.size.height);
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:self.marqueeAnimationDuration];
    [UIView setAnimationDelay:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(verticalLoopAnimationDidStop:finished:context:)];
    CGRect firstContentLabelFrame = self.firstContentLabel.frame;
    firstContentLabelFrame.origin.y = firstContentLaEndY;
    
    [self.firstContentLabel setFrame:firstContentLabelFrame];
    [self.secondContentLabel setFrame:CGRectMake(10,secondContentLaEndY, self.frame.size.width - 20, self.frame.size.height)];
    [UIView commitAnimations];
    
}

-(void)verticalLoopAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    
    self.currentIndex++;
    if(self.currentIndex >= [self.marqueeArray count]) {
        self.currentIndex = 0;
    }
    [self startVerticalLoopAnimation];
    
}
- (void)loopContentClick
{
    if ([self.loopDelegate respondsToSelector:@selector(marqueeDidClickContentAtIndex:)]) {
        
        MarqueeModel *model = [self.marqueeArray objectAtIndex:self.currentIndex];
        
        [self.loopDelegate marqueeDidClickContentAtIndex:model];
    }
}
#pragma mark - verticalLoop Animation Handling
-(void)start {
    
    // 开启动画默认第一条信息
    self.currentIndex = 0;
    // 开始动画
    [self startVerticalLoopAnimation];
}

@end
