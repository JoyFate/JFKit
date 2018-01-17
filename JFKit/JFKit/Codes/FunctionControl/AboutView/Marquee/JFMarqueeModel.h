//
//  JFMarqueeModel.h
//  StockOffLine-dev
//
//  Created by MAC on 2018/1/11.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger) {
    JFMarqueeJumpType_App = 0,      // app 内页跳转
    JFMarqueeJumpType_Web,          // app 网页跳转
}JFMarqueeJumpType;

@interface JFMarqueeModel : NSObject

@property (nonatomic, copy) NSString *modelId;                  // id
@property (nonatomic, copy) NSString *title;                    // 显示标题
@property (nonatomic, assign) JFMarqueeJumpType jumpType;       // 跳转类型

@end
