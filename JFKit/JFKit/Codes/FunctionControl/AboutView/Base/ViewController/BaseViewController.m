//
//  BaseViewController.m
//  HaiSeDedicatedShip
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "BaseViewController.h"
#import "JFTabbarViewController.h"
#import "JFColor.h"
#import "JFDeviceInfo.h"

#define kNavRightLeftColor RGB(51, 51, 51)          // 导航栏左右按钮字体颜色
#define kNavTitleColor RGB(255, 255, 255)           // 导航栏标题颜色
#define kNavTitleFontSize fJFFontSize(38)           // 导航栏标题字体大小
#define kMainBlueColor RGB(63, 85, 102)             // 主体蓝色

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View
- (UIButton *)makeBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTintColor:kNavRightLeftColor];
    return backButton;
}

- (UILabel *)makeTitleLabelWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:title];
    [titleLabel setFont:[UIFont systemFontOfSize:kNavTitleFontSize]];
    [titleLabel setTextColor:kNavTitleColor];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    return titleLabel;
}

- (UIView *)addTitleViewWithTitle:(NSString *)titleText
{
    UIView *titleView = [self addTitleClearViewWithTitle:titleText];
    [titleView setBackgroundColor:kMainBlueColor];
    
    return titleView;
}

- (UIView *)addTitleClearViewWithTitle:(NSString *)titleText
{
    UIView *titleView = [[UIView alloc] init];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo( [JFDeviceInfo isIPhoneXSize] ? 84 : 64);
    }];
    
    if (self.navigationController.viewControllers.count > 1) {
        _backButton = [self makeBackButton];
        [titleView addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleView.mas_left);
            make.bottom.equalTo(titleView);
            make.height.mas_equalTo(44);
            make.width.mas_equalTo(28 + 38/2);
        }];
    }
    
    UILabel *titleLabel = [self makeTitleLabelWithTitle:titleText];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(titleView);
        make.height.mas_equalTo(44);
    }];
    self.titleLabel = titleLabel;
    
    return titleView;
}

- (UIViewController *)topViewController
{
    UIViewController *rootVC = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // navigationController
        return [rootVC.navigationController topViewController];
    }
    else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // tabbarController
        return (UIViewController *)[(UITabBarController *)rootVC selectedViewController];
    }
    else {
        // viewController
        return rootVC;
    }
}

#pragma mark - button Click
- (void)backButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Setter
- (void)setBadgValue:(NSString *)value index:(NSInteger)index
{
    [[JFTabbarViewController sharedJFTabbarViewController] setTabBarItemValue:value index:index];
}

@end
