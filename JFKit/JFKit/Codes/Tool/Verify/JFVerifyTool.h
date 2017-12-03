//
//  VerifyTool.h
//  hszt
//
//  Created by hudan on 2017/5/12.
//  Copyright © 2017年 zxwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFVerifyTool : NSObject

/**
 校验手机号码格式是否正确

 @param mobile 手机号码
 @return  YES:正确  /  NO: 错误
 */
+ (BOOL)valiMobile:(NSString *)mobile;

@end
