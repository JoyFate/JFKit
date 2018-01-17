//
//  JFMarqueeView.h
//  StockOffLine-dev
//
//  Created by MAC on 2018/1/11.
//  Copyright © 2018年 MAC. All rights reserved.
//

/**
    跑马灯
 */

#import <UIKit/UIKit.h>

#import "JFMarqueeModel.h"

typedef void(^MarqueeClickBlock)(JFMarqueeModel *model);

@interface JFMarqueeView : UIView

@property (nonatomic, strong) NSArray<JFMarqueeModel *> *dataArray;             // 数据源
@property (nonatomic, copy) MarqueeClickBlock clickBlock;                       // 点击的响应 block

/**
 推荐初始化方法

 @param fontSize 字体大小
 @param textColor 字体颜色
 @param duriection 间隔时间
 @param clickBlock 点击事件
 @return 实例对象
 */
- (instancetype)initWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor durection:(NSTimeInterval)duriection clickBlock:(void(^)(JFMarqueeModel *model))clickBlock;

/**
 开始动画
 */
- (void)start;

@end
