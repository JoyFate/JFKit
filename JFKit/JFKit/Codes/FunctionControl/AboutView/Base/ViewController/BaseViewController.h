//
//  BaseViewController.h
//  HaiSeDedicatedShip
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface BaseViewController : UIViewController

// tabBariItem
@property (nonatomic, strong) UIImage *itemNormalImage; // 当前未选中Item图片
@property (nonatomic, strong) UIImage *itemSelectImage; // 当前选中的Item图片

@property (nonatomic, strong) UIButton *backButton;     // 返回按钮
@property (nonatomic, strong) UILabel *titleLabel;      // 通过addTitleViewWithTitle创建的头 titleLabel 为标题

// navigationController
@property (nonatomic, strong) UINavigationController *currNavigationController; // 有的viewController没有navigationController通过属性设置用于跳转

#pragma mark - view
/**
 创建 navigationBar 的返回按钮

 @return 生成的返回按钮
 */
- (UIButton *)makeBackButton;

/**
 创建标题label

 @param title 标题内容
 @return 生成的标题label
 */
- (UILabel *)makeTitleLabelWithTitle:(NSString *)title;

/**
 创建controller 的title 视图
 
 @param titleText title 文字
 @return 创建后的视图
 */
- (UIView *)addTitleViewWithTitle:(NSString *)titleText;

/**
 创建controller 的无背景色的title 视图

 @param titleText title 文字
 @return 创建后的视图
 */
- (UIView *)addTitleClearViewWithTitle:(NSString *)titleText;

/**
 获取最顶部的 viewController
 
 @return 当前控制器的最顶层的 viewController
 */
- (UIViewController *)topViewController;


#pragma mark - button click
/**
 返回按钮点击事件
 
 @param sender 返回按钮
 */
- (void)backButtonClick:(UIButton *)sender;

#pragma mark - Setter
/**
 设置 tabBarItem 的 value 显示
 
 @param value value
 @param index 索引值
 */
- (void)setBadgValue:(NSString *)value index:(NSInteger)index;

@end
