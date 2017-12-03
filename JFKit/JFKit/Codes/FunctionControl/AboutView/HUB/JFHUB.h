//
//  JFHUB.h
//  JFKit
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Singleton.h"

#define JFProcessHUB [JFHUB sharedJFHUB]

@interface JFHUB : NSObject

SingletonH(JFHUB)


@property (nonatomic, strong) UIView *customView;

/* *
 * 显示一个自定时间的,上图下文的
 * name 图片名字
 * time 显示时间
 * message 提示文字
 */
- (void)showImage:(NSString *)name time:(NSTimeInterval)time message:(NSString *)message;

/* *
 * 显示一个时间为1.5秒的,纯文字的
 * message 提示文字
 */
- (void)showMessage:(NSString *)message;

/* *
 * 显示一个自定时间的,纯文字的
 * message 提示文字
 * time 显示时间
 */
- (void)showMessage:(NSString *)message time:(NSTimeInterval)time;


/* *
 * 显示一个自定时间的,纯文字的,可自定父视图
 * message 提示文字
 * time 显示时间
 * view 父视图
 */
- (void)showMessage:(NSString *)message time:(NSTimeInterval)time view:(UIView *)view;

/* *
 * 显示一个时间为3秒的,菊花加载样式的,纯文字的,可自定父视图
 * message 提示文字
 */
- (void)showLoadding:(NSString *)message;

/* *
 * 显示一个自定时间的,菊花加载样式的,纯文字的
 * message 提示文字
 * time 显示时间
 */
- (void)showLoadding:(NSString *)message time:(NSTimeInterval)time;

/* *
 * 显示一个自定时间的,菊花加载样式的,纯文字的,可自定父视图
 * message 提示文字
 * time 显示时间
 * view 父视图
 */
- (void)showLoadding:(NSString *)message time:(NSTimeInterval)time view:(UIView *)view;

/**
 取消显示
 */
- (void)dismissHub;


@end
