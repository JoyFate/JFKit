//
//  CardView.h
//  CardTest
//
//  Created by hudan on 2017/6/30.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

/**
    可重用视图
 
    子类实现自定义视图,子类视图布局不可使用 Masonry, 使用 setFrame 设置.
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    JFCardItemRemoveDirection_Left = 0,
    JFCardItemRemoveDirection_Right,
}JFCardItemRemoveDirection;

@class JFCardItemView;

@protocol JFCardItemViewDelegate <NSObject>

@optional
- (void)itemDidRemove:(JFCardItemView *)cardItem direction:(JFCardItemRemoveDirection)direction;

@end

@interface JFCardItemView : UIView

@property (nonatomic, weak) id<JFCardItemViewDelegate> delegate;
@property (nonatomic, assign) CGFloat cardRadius;

// 取消圆角
- (void)cancelRadius;

- (void)removeWithDirection:(JFCardItemRemoveDirection)direction;

@end
