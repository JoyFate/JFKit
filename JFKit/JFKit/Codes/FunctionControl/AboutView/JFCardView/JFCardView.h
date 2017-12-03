//
//  JFCardView.h
//  CardTest
//
//  Created by hudan on 2017/7/3.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

/**
    类似探探的卡片滑动效果
 */

#import <UIKit/UIKit.h>
#import "JFCardItemView.h"

typedef NS_ENUM(NSInteger) {
    JFCardViewType_Normal = 0,      // 左滑上一个,右滑下一个
    JFCardViewType_JustToNext,      // 左滑右滑都是下一个
}JFCardViewType;

typedef void(^NoMoreDataBlock)();

@protocol JFCardViewDelegate <NSObject>

@required
/**
 cardView 的所有卡片总数

 @return 卡片总数
 */
- (NSUInteger)cardViewNumbers;

/**
 下一张卡片数据源绑定代理方法

 @param cardItem 下一张卡片
 @param index 卡片的索引
 */
- (void)cardViewWillShow:(JFCardItemView *)cardItem index:(NSUInteger)index;

@optional

/**
 需要加载更多数据
 */
- (void)cardNeedLoadMoreData;

@end

@interface JFCardView : UIView

@property (nonatomic, weak) id<JFCardViewDelegate> delegate;

@property (nonatomic, assign) BOOL isNoMoreData;                // 是否已无更多数据
@property (nonatomic, assign) JFCardViewType cardViewType;      // 卡片滑动类型
@property (nonatomic, copy) NoMoreDataBlock noMoreDataBlock;    // 无更多数据调用的 block
@property (nonatomic, strong, readonly) JFCardItemView *currItemView;   // 当前的 item 视图

/**
    统一初始化方法

 @param frame  视图的frame
 @param itemView1 第一个 JFCardItemView 子类
 @param itemView2 第二个 JFCardItemView 子类
 @param delegate 代理
 @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                    itemView1:(JFCardItemView *)itemView1
                    itemView2:(JFCardItemView *)itemView2
                     delegate:(id<JFCardViewDelegate>)delegate;

/**
    重新加载
 */
- (void)reloadData;

/**
 左滑到下一个
 */
- (void)leftToNext;

/**
 右滑到下一个
 */
- (void)rigthToNext;

@end
