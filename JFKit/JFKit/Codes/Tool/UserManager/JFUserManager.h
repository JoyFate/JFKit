//
//  JFUserManager.h
//  JFKit
//
//  Created by hudan on 2017/6/29.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "JFUserModel.h"

// 通知
#define kJFUserLoginNoti @"kJFUserLoginNoti"                      // 用户登录通知
#define kJFUserLogoutNoti @"kJFUserLogoutNoti"                    // 用户退出通知

@interface JFUserManager : NSObject

SingletonH(JFUserManager)


/**
 注册 UserManager
 */
- (void)registerUserManager;

- (BOOL)hasUserLogin;

- (void)userLogin;
- (void)userLoginOut;

@end
