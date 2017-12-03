//
//  JFUserManager.m
//  JFKit
//
//  Created by hudan on 2017/6/29.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFUserManager.h"
#import "NSUserDefaults+JF.h"

@interface JFUserManager ()

@property (nonatomic, strong) JFUserModel *userModel;

@end

@implementation JFUserManager

SingletonM(JFUserManager)

- (void)registerUserManager
{
    NSString *userId = [JFUserDefaults jf_objectForKey:kJFUserId];
    
    if (userId.length > 0) {
        // 创建 userModel
        JFUserModel *model = [[JFUserModel alloc] init];
        
        model.userId = userId;
        model.userName = [JFUserDefaults jf_objectForKey:kJFUserName];
        model.headerIcon = [JFUserDefaults jf_objectForKey:kJFUserHeaderIcon];
        
        self.userModel = model;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogin) name:kJFUserLoginNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginOut) name:kJFUserLogoutNoti object:nil];
}

- (BOOL)hasUserLogin
{
    return self.userModel ? YES : NO;
}

- (void)userLogin
{
    
}

- (void)userLoginOut
{
    [JFUserDefaults setValue:nil forKey:kJFUserId];
    [JFUserDefaults setValue:nil forKey:kJFUserName];
    [JFUserDefaults setValue:nil forKey:kJFUserHeaderIcon];
}

@end
