//
//  JFAlertView.h
//  JFKit
//
//  Created by hudan on 2017/8/28.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

/**
    UIAlertView 点击通过 block 实现
 */

#import <UIKit/UIKit.h>

@class JFAlertView;

typedef void(^JFAlertViewButtonBlock)(JFAlertView *alertView, NSInteger buttonIndex);

@interface JFAlertView : UIAlertView

@property (nonatomic, copy) JFAlertViewButtonBlock buttonClickBlock;

@end
