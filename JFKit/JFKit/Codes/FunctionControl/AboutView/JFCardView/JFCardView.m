//
//  JFCardView.m
//  CardTest
//
//  Created by hudan on 2017/7/3.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFCardView.h"

@interface JFCardView () <JFCardItemViewDelegate>

@property (nonatomic, strong) JFCardItemView *itemView1;
@property (nonatomic, strong) JFCardItemView *itemView2;
@property (nonatomic, strong) JFCardItemView *showingItemView;  // 正在显示的 item 视图

@property (nonatomic, assign) NSUInteger index;

@end

@implementation JFCardView

#pragma mark - Public

- (instancetype)initWithFrame:(CGRect)frame
                    itemView1:(JFCardItemView *)itemView1
                    itemView2:(JFCardItemView *)itemView2
                     delegate:(id<JFCardViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.itemView1 = itemView1;
        self.itemView2 = itemView2;
        
        self.itemView1.delegate = self.itemView2.delegate = self;
        
        self.delegate = delegate;
        
        self.index = 0;
        
        self.cardViewType = JFCardViewType_Normal;
        
        [self initUI];
    }
    return self;
}

- (void)leftToNext
{
    if (![self moveCheck]) {
        return;
    }
    
    [self.showingItemView removeWithDirection:JFCardItemRemoveDirection_Left];
}

- (void)rigthToNext
{
    if (![self moveCheck]) {
        return;
    }
    
    [self.showingItemView removeWithDirection:JFCardItemRemoveDirection_Right];
}

// 移动前的校验
- (BOOL)moveCheck
{
    NSUInteger count = [self.delegate cardViewNumbers];
    
    if (self.index + 1 >= count) {
        if (self.noMoreDataBlock) {
            self.noMoreDataBlock();
        }
        
        return NO;
    }
    else
        return YES;
}

- (void)reloadData
{
    self.index = 0;
    
    self.itemView1.userInteractionEnabled = YES;
    self.itemView2.userInteractionEnabled = YES;
    
    if ([self.delegate respondsToSelector:@selector(cardViewWillShow:index:)]) {
        [self.delegate cardViewWillShow:self.showingItemView index:0];
        
        [self.delegate cardViewWillShow:[self.showingItemView isEqual:self.itemView1] ? self.itemView2 :  self.itemView1 index:1];
    }
}

#pragma mark - Private

- (void)initUI
{
    [self addSubview:self.itemView1];
    
    [self insertSubview:self.itemView2 belowSubview:self.itemView1];
    
    self.itemView1.frame = self.itemView2.frame = self.bounds;
    
    self.showingItemView = self.itemView1;
    
    if ([self.delegate respondsToSelector:@selector(cardViewWillShow:index:)]) {
        [self.delegate cardViewWillShow:self.itemView1 index:0];
        
        [self.delegate cardViewWillShow:self.itemView2 index:1];
    }
}

/**
 获取可用的 itemView

 @return 可用的 itemView
 */
- (JFCardItemView *)getItemViewToUse
{
    if ([self.showingItemView isEqual:self.itemView1]) {
        self.showingItemView = self.itemView2;
        return self.itemView2;
    }
    else {
        self.showingItemView = self.itemView1;
        return self.itemView1;
    }
}

#pragma mark - JFCardItemView Delegate
- (void)itemDidRemove:(JFCardItemView *)cardItem direction:(JFCardItemRemoveDirection)direction
{
    if (self.cardViewType == JFCardViewType_Normal) {
        if (direction == JFCardItemRemoveDirection_Right) {
            if (self.index == 0) {
                self.index = [self.delegate cardViewNumbers] - 1;
            }
            else {
                self.index--;
            }
        }
        else {
            if (self.index == [self.delegate cardViewNumbers] - 1) {
                self.index = 0;
            }
            else {
                self.index++;
            }
        }
    }
    else {
        self.index++;
    }
    
    NSUInteger count = [self.delegate cardViewNumbers];
    
    if (self.index + 1 < count) {
        if ([self.delegate respondsToSelector:@selector(cardViewWillShow:index:)]) {
            [self.delegate cardViewWillShow:self.showingItemView index:self.index + 1];
        }
    }
    
    JFCardItemView *nextItem = [self getItemViewToUse];
    
    if (self.index < count) {
        if ([self.delegate respondsToSelector:@selector(cardViewWillShow:index:)]) {
            [self.delegate cardViewWillShow:nextItem index:self.index];
        }
    }
    
    [self insertSubview:self.showingItemView belowSubview:nextItem];
    self.showingItemView = nextItem;
    
}

#pragma mark - Setter
- (void)setIndex:(NSUInteger)index
{
    _index = index;
    
    // 到最后一张,不可再滑动
    if (self.cardViewType == JFCardViewType_JustToNext) {
        if (index == [self.delegate cardViewNumbers] - 1) {
            self.itemView1.userInteractionEnabled = NO;
            self.itemView2.userInteractionEnabled = NO;
            
            if (self.noMoreDataBlock) {
                self.noMoreDataBlock();
            }
            
            return;
        }
    }
    
    NSUInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(cardViewNumbers)]) {
        count = [self.delegate cardViewNumbers];
    }

    if (index + 2 == count - 1) {
        if ([self.delegate respondsToSelector:@selector(cardNeedLoadMoreData)] && !self.isNoMoreData) {
            [self.delegate cardNeedLoadMoreData];
        }
    }
}

#pragma mark - Getter
- (JFCardItemView *)currItemView
{
    return self.showingItemView;
}

@end
