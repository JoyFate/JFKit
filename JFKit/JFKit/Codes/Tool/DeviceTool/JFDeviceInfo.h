//
//  JFDeviceInfo.h
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 joyFate. All rights reserved.
//

/**
 *  与设备相关的类：设备信息，调用设备功能
 */

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

// 屏幕相关
#define kJFAppWidth  [[UIScreen mainScreen] bounds].size.width                          // 屏幕宽度
#define kJFAppHeight [[UIScreen mainScreen] bounds].size.height                         // 屏幕高度

#define kStatusHeight  20                                                               // 状态栏高度
#define kNaviBarHeight 44                                                               // 导航栏高度
#define kTabBarHeight  49                                                               // tabbar高度

#define fJFScreen(x)   ((x)/2 * [JFDeviceInfo screenMultipleIn6])     // 项目中使用的屏幕适配(px)
#define fJFFontSize(x) (x/2 > 12 ? ((x)/2 * [JFDeviceInfo screenMultipleIn6]) : x/2)    // 字体适配 <4寸屏小于12号字体不缩放>
#define fJFScreen6(x)  ((x) * [JFDeviceInfo screenMultipleIn6])       // 4.7 屏幕下的值
#define fJFScreen6p(x) ((x) * [JFDeviceInfo screenMultipleIn6p])      // 5.5 屏幕下的值

// 系统版本
#define kJFSystem_iOS_6 6
#define kJFSystem_iOS_7 7
#define kJFSystem_iOS_8 8
#define kJFSystem_iOS_9 9
#define kJFSystem_iOS_10 10
#define kJFSystem_iOS_11 11

@interface JFDeviceInfo : NSObject

#pragma mark - 版本相关
/**
 获取当前系统版本

 @return 系统大版本号
 */
+ (NSInteger)getCurrentOSVersion;

/**
 获取当前 App 版本

 @return APP 版本号
 */
+ (NSString *)getCurrentAppVersion;

/**
 获取当前 APP 构建版本号

 @return APP 构建版本号
 */
+ (NSInteger)getCurrentAppBuildVersion;


#pragma mark - 屏幕相关
+ (float)screenMultipleIn6;
+ (float)screenMultipleIn6p;

#pragma mark - 判断设备
+ (BOOL)isIPhone4Size;
+ (BOOL)isIPhone5Size;
+ (BOOL)isIPhone6Size;
+ (BOOL)isIPhone6PSize;
+ (BOOL)isIPhoneXSize;

#pragma mark - 调用设备功能
/**
 *  调用电话功能拨打电话
 *
 *  @param phoneNumber 要拨打的电话号码
 */
+ (void)callPhoneWithPhoneNumber:(NSString *)phoneNumber;

#pragma mark - 权限判断
/**
 是否开启相机权限

 @return YES:开启  /  NO:未开启
 */
+ (BOOL)isGetCameraPermission;

/**
 是否开启相册权限

 @return YES:开启  /  NO:未开启
 */
+ (BOOL)isGetPhotoPermission;

/**
 是否开启定位权限

 @return YES:开启  /  NO:未开启
 */
+ (BOOL)isGetLocationPermission;

#pragma mark - 设备控制
/**
 是否禁止手机睡眠
 */
+ (void)setLockScreen:(BOOL)isLock;



@end
