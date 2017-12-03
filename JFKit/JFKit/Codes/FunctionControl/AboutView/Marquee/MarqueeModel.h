//
//  MarqueeModel.h
//  JFKit
//
//  Created by joyFate on 2017/3/15.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

/**
    跑马灯模型
 */

#import <Foundation/Foundation.h>
#import "JFButton.h"

typedef NS_ENUM(NSInteger) {
    JFBannerJumpType_Goods = 0,           // 跳转商品详情
    JFBannerJumpType_Shop,                // 跳转店铺
    JFBannerJumpType_Web                  // 跳转web
}JFBannerJumpType;

@interface MarqueeModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) JFBannerJumpType *jumpType;
@property (nonatomic, copy) NSString *jumpURL;

@end
