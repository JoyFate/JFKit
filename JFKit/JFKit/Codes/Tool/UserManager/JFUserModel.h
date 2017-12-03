//
//  JFUserModel.h
//  JFKit
//
//  Created by hudan on 2017/6/29.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kJFUserId @"JFUserId"
#define kJFUserName @"JFUserName"
#define kJFUserHeaderIcon @"JFUserHeaderIcon"

@interface JFUserModel : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *headerIcon;


@end
