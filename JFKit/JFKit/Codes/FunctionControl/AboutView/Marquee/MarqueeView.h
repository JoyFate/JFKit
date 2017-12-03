//
//  MarqueeView.h
//  JFKit
//
//  Created by joyFate on 2017/3/14.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

/**
    跑马灯
 */

#import <UIKit/UIKit.h>
#import "MarqueeModel.h"

@protocol MarqueeViewDelegate<NSObject>

- (void)marqueeDidClickContentAtIndex:(MarqueeModel *)model;

@end

typedef enum
{
    MarqueeViewDirectionBottom,
    MarqueeViewDirectionDown,
    
}MarqueeViewDirection;

@interface MarqueeView : UIView

/** 动画方向默认往上
 *  跑马灯动画时间
 */
@property(nonatomic) float marqueeAnimationDuration;
/**
 *  显示的内容(支持多条数据)
 */
@property(nonatomic, retain) NSArray<MarqueeModel *> *marqueeArray;
/**
 * loop方向(上下/右)
 */
@property(nonatomic) MarqueeViewDirection Direction;
@property (nonatomic)id<MarqueeViewDelegate> loopDelegate;
/**
 *  开启
 */
-(void)start;

@end
