//
//  JFTabbarViewController.m
//  JFKit
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFTabbarViewController.h"
#import <objc/runtime.h>
#import "JFDeviceInfo.h"
#import "UITabBar+JF.h"
#import "JFColor.h"

#define kJFTabbarDefaultIndex 0

@interface JFTabbarViewController ()

@end

@implementation JFTabbarViewController

SingletonM(JFTabbarViewController)

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    // 默认值
    self.tabBar.translucent = NO;   // 不透明
    self.shadow = YES;              // 阴影
    
    // 初始化 UI
    [self setItemUI];
}

- (void)setItemUI
{
    NSArray *items = self.tabBar.items;
    
    if (self.itemFontNormalColor) {
        [self setTabBarItemsFontNormalColor:self.itemFontNormalColor items:items];
    }
    if (self.itemFontSelectColor) {
        [self setTabBarItemsFontSelectColor:self.itemFontSelectColor items:items];
    }
    if (self.itemFontSize != 0) {
        [self setTabBarItemsFontSize:self.itemFontSize items:items];
    }
}

- (void)setTabBarItemsFontSize:(CGFloat)fontSize items:(NSArray *)items
{
    for (UITabBarItem *item in items) {
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.itemFontSize]} forState:UIControlStateNormal];
    }
}

- (void)setTabBarItemsFontNormalColor:(UIColor *)color items:(NSArray *)items
{
    [self.tabBar setTintColor:color];
    
    for (UITabBarItem *item in items) {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
    }
}

- (void)setTabBarItemsFontSelectColor:(UIColor *)color items:(NSArray *)items
{
    [self.tabBar setTintColor:color];
    
    for (UITabBarItem *item in items) {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateSelected];
    }
}

#pragma mark - Public
- (void)setItemTitle:(NSString *)title
           imageName:(NSString *)imageName
     selectImageName:(NSString *)selectImageName
               index:(NSInteger)index
{
    if (self.viewControllers) {
        
        if (index < self.viewControllers.count) {
            
            UIViewController *viewController = [self.viewControllers objectAtIndex:index];
            
            [viewController.tabBarItem setTitle:title];
            [viewController.tabBarItem setImage:[UIImage imageNamed:imageName]];
            [viewController.tabBarItem setSelectedImage:[UIImage imageNamed:selectImageName]];
        }
        else {
#ifdef DEBUG
            NSAssert(NO, @"索引越界!");
#endif
        }
    }
}

- (void)setTabBarItemValue:(NSString *)value index:(NSInteger)index
{
    [self.tabBar setBadgValueWithIndex:index number:value backgroundColor:HexColor(0xe44a62) textColor:[UIColor whiteColor]];
}

#pragma mark - Setter
- (void)setTranslucent:(BOOL)translucent
{
    self.tabBar.translucent = translucent;
}

- (void)setShadow:(BOOL)shadow
{
    if (shadow) {
        self.tabBar.layer.shadowColor = RGB(100, 100, 100).CGColor;//阴影颜色
        self.tabBar.layer.shadowOffset = CGSizeMake(0 , 1);//偏移距离
        self.tabBar.layer.shadowOpacity = 0.5;//不透明度
        self.tabBar.layer.shadowRadius = 5.0;//半径
    }
    else {
        self.tabBar.layer.shadowColor = [UIColor whiteColor].CGColor;//阴影颜色
        self.tabBar.layer.shadowOffset = CGSizeMake(0 , 0);//偏移距离
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, kJFAppWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, lineColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    
    self.tabBar.tintColor = tintColor;
}

- (void)setItemFontSize:(CGFloat)itemFontSize
{
    _itemFontSize = itemFontSize;
    
    NSArray *items = self.tabBar.items;
    
    if ([items count] > 0) {
        [self setTabBarItemsFontSize:_itemFontSize items:items];
    }
}

- (void)setItemFontNormalColor:(UIColor *)itemFontNormalColor
{
    _itemFontNormalColor = itemFontNormalColor;
    
    NSArray *items = self.tabBar.items;
    
    if ([items count] > 0) {
        [self setTabBarItemsFontNormalColor:_itemFontNormalColor items:items];
    }
}

- (void)setItemFontSelectColor:(UIColor *)itemFontSelectColor
{
    _itemFontSelectColor = itemFontSelectColor;
    
    NSArray *items = self.tabBar.items;
    
    if ([items count] > 0) {
        [self setTabBarItemsFontSelectColor:_itemFontSelectColor items:items];
    }
}

@end
