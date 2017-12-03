//
//  JFNumberView.h
//  JFKit
//
//  Created by joyFate on 16/7/28.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    JFNumberChangeType_Add = 0,   // 加
    JFNumberChangeType_Sub = 1,   // 减
}JFNumberChangeType;

typedef BOOL(^NumberWillChangeBlock)(NSInteger number, JFNumberChangeType type);
typedef BOOL(^NumberDidChangeBlock)(NSInteger number, JFNumberChangeType type);
typedef void(^NumberOverMaxBlock)(NSInteger maxNumer);

@interface JFNumberView : UIView

@property (nonatomic, assign) NSInteger number;         // 显示的number
@property (nonatomic, assign) CGFloat fontSize;         // 显示的数字的字体大小
@property (nonatomic, assign) NSInteger maxNumber;      // 最大值
@property (nonatomic, copy) NSString *addButtonImage;   // 加号按钮图片
@property (nonatomic, copy) NSString *subButtonImage;   // 减号按钮图片

@property (nonatomic, assign) BOOL canEdit; // 加减号是否可以使用

@property (nonatomic, copy) NumberDidChangeBlock numberDidChangeBlock;          // 数字将要改变的block
@property (nonatomic, copy) NumberWillChangeBlock numberWillChangeBlock;        // 数字已经改变的block
@property (nonatomic, copy) NumberOverMaxBlock numberOverMaxBlock;              // 当数字超过最大值时候的block


/**
 初始化方法

 @param number 初始化后显示的数量
 @param height 控件的高度

 @return 实例化的对象
 */
- (instancetype)initWithNumber:(NSInteger)number viewHeight:(CGFloat)height;

@end
