//
//  JFButton.h
//  JFKit
//
//  Created by hudan on 16/9/5.
//  Copyright © 2016年 胡丹. All rights reserved.
//

#import <UIKit/UIKit.h>

// 图片位置类型枚举
typedef NS_ENUM(NSInteger) {
    JFButtonType_Default = 0,       // 默认, 图片居左
    JFButtonType_ImageRight,        // 图片居右, 默认
    JFButtonType_ImageTop,          // 图片居上
}JFButtonType;

@class JFButton;

typedef void(^ButtonActionBlock)(JFButton *sender);

@interface JFButton : UIButton

@property (nonatomic, copy) ButtonActionBlock clickBlock;

@property (nonatomic, copy) NSString *title;                // 标题
@property (nonatomic, copy) NSString *titleSelected;        // 选中状态下的标题
@property (nonatomic, strong) UIColor *bgColor;             // 背景颜色
@property (nonatomic, strong) UIColor *bgSelectedColor;     // 选中的背景颜色 <默认为背景颜色,未设置背景颜色,则为白色>
@property (nonatomic, strong) UIColor *titleColor;          // 标题颜色
@property (nonatomic, strong) UIColor *titleHightColor;     // 标题高亮颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;  // 标题选中状态颜色 <默认为标题颜色,未设置标题颜色,则为黑色>
@property (nonatomic, assign) CGFloat titleFontSize;        // 文字颜色
@property (nonatomic, strong) UIImage *buttonImage;         // 图片
@property (nonatomic, strong) UIImage *buttonSelectedImage;    // 选中图片

@property (nonatomic, assign) JFButtonType buttonImageType;
@property (nonatomic, assign) CGFloat verImageTitleSpacing; // 上图下文字按钮中图片和文字的间距(注意:设置图片和文字后调用 setter 方法)
@property (nonatomic, assign) CGFloat horImageTitleSpacing; // 右图左文字按钮中图片和文字的间距


/**
 快捷初始化方法

 @return  实例对象
 */
+ (instancetype)make;

+ (instancetype)makeWithTitle:(NSString *)title
                     fontSize:(CGFloat)fontSize
                    fontColor:(UIColor *)fontColor
                fontSelectColor:(UIColor *)fontSelectColor
                        image:(UIImage *)image
                  selectImage:(UIImage *)selectImage
                       target:(id)target
                       action:(SEL)action;

/**
 添加按钮响应方法

 @param target 响应者
 @param action 方法
 */
- (void)addTarget:(id)target action:(SEL)action;

@end
