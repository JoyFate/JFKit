//
//  BaseNavigationController.m
//  HaiSeDedicatedShip
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 默认隐藏navigationBar
    [self.navigationBar setHidden:YES];
}

#pragma mark - UINavigationController 方法重载
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
