//
//  JFTabbarViewController.h
//  JFKit
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface JFTabbarViewController : UITabBarController

SingletonH(JFTabbarViewController)

// 自定义 UI
@property (nonatomic, assign) CGFloat itemFontSize;             // items 的字体大小  ps:文字的大小必须在设置文字颜色之前,否则无效
@property (nonatomic, strong) UIColor *itemFontNormalColor;     // items 普通状态下的文字颜色
@property (nonatomic, strong) UIColor *itemFontSelectColor;     // items 选中状态下的文字颜色
@property (nonatomic, strong) UIColor *tintColor;               // item 的渲染颜色
@property (nonatomic, strong) UIColor *lineColor;               // tabbar 线条颜色
@property (nonatomic, strong) UIColor *badeValueBgColor;        // 计数器的背景颜色
@property (nonatomic, assign) BOOL shadow;                      // 是否有阴影 默认有
@property (nonatomic, assign) BOOL translucent;                 // 是否半透明 默认不透明


/**
 设置指定的item 的文字,图片信息

 @param title 文字
 @param imageName 图片
 @param selectImageName 选中图片
 @param index item 索引值
 */
- (void)setItemTitle:(NSString *)title
           imageName:(NSString *)imageName
     selectImageName:(NSString *)selectImageName
               index:(NSInteger)index;

/**
 设定 tabbarItem 的 value
 
 @param value value 值
 @param index item 的索引值
 */
- (void)setTabBarItemValue:(NSString *)value index:(NSInteger)index;

@end
