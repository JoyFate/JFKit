//
//  CardView.m
//  CardTest
//
//  Created by hudan on 2017/6/30.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFCardItemView.h"

@interface JFCardItemView ()

@property (nonatomic, assign) CGPoint initCenter;   // 初始的中心
@property (nonatomic, assign) CGFloat currAngle;    // 当前的角度
@property (nonatomic, assign) BOOL isLeft;          // 滑动方向是否是向左

@property (nonatomic, assign) BOOL animationFinish; // 动画是否结束

@end

@implementation JFCardItemView

#pragma mark - Public

- (instancetype)init
{
    if (self = [super init]) {
        [self addPanGest];
        
        [self initViewProperties];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.initCenter = self.center;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.initCenter = self.center;
        
        [self addPanGest];
        
        [self initViewProperties];
    }
    return self;
}

- (void)cancelRadius
{
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = NO;
}

- (void)setCardRadius:(CGFloat)cardRadius
{
    _cardRadius = cardRadius;
    
    self.layer.cornerRadius = cardRadius;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
}

- (void)removeWithDirection:(JFCardItemRemoveDirection)direction
{
    // 处理动画未结束,外界多次点击下一张导致的界面异常问题
    if (!self.animationFinish) {
        return;
    }
    
    self.animationFinish = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        // right
        if (direction == JFCardItemRemoveDirection_Left) {
            self.center = CGPointMake(self.frame.size.width + 1000, self.center.y + self.currAngle * self.frame.size.height + (self.currAngle == 0 ? 100 : 0));
        } else { // left
            self.center = CGPointMake(- 1000, self.center.y - self.currAngle * self.frame.size.height + (self.currAngle == 0 ? 100 : 0));
        }
    } completion:^(BOOL finished) {
        if (finished) {
            
            self.center = self.initCenter;
            self.transform = CGAffineTransformMakeRotation(0);
            
            if ([self.delegate respondsToSelector:@selector(itemDidRemove:direction:)]) {
                [self.delegate itemDidRemove:self direction:direction];
            }
            
            self.animationFinish = YES;
        }
    }];
}


#pragma mark - Private

- (void)initViewProperties
{
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.animationFinish = YES;
}

/**
 添加手势
 */
- (void)addPanGest
{
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
    [self addGestureRecognizer:pan];
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint movePoint = [pan translationInView:self];
        _isLeft = (movePoint.x < 0);
        
        self.center = CGPointMake(self.center.x + movePoint.x, self.center.y + movePoint.y);
        
        CGFloat angle = (self.center.x - self.frame.size.width / 2.0) / self.frame.size.width / 4.0;
        self.currAngle = angle;
        
        self.transform = CGAffineTransformMakeRotation(angle);
        
        [pan setTranslation:CGPointZero inView:self];
        
    } else if (pan.state == UIGestureRecognizerStateEnded) {

        CGPoint vel = [pan velocityInView:self];
        if (vel.x > 800 || vel.x < - 800) {
            [self remove];
            return ;
        }
        if (self.frame.origin.x + self.frame.size.width > 150 && self.frame.origin.x < self.frame.size.width - 150) {
            [UIView animateWithDuration:0.5 animations:^{
                self.center = self.initCenter;
                self.transform = CGAffineTransformMakeRotation(0);
            }];
        } else {
            [self remove];
        }
    }
}

// 移除动画
- (void)remove {
    
    if ([self.delegate respondsToSelector:@selector(itemDidRemove:direction:)]) {
        [self.delegate itemDidRemove:self direction:!self.isLeft];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        // right
        if (!_isLeft) {
            self.center = CGPointMake(self.frame.size.width + 1000, self.center.y + self.currAngle * self.frame.size.height);
        } else {
            // left
            self.center = CGPointMake(- 1000, self.center.y - self.currAngle * self.frame.size.height);
        }
    } completion:^(BOOL finished) {
        
        if (finished) {
            self.center = self.initCenter;
            self.transform = CGAffineTransformMakeRotation(0);
            
        }
    }];
}


@end
