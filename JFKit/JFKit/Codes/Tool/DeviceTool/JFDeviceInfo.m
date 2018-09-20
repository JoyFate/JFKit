//
//  JFDeviceInfo.m
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFDeviceInfo.h"

#import <UIKit/UIKit.h>

#import "JFCommHeader.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>

@implementation JFDeviceInfo

// 4.7寸屏幕为基准的适配比例
+ (float)screenMultipleIn6
{
    // iPhone X 和 Plus 同宽度, 高度更高, 所以适配同 Plus
    if ([JFDeviceInfo isIPhoneXSize]) {
        return 1;
    }
    return kJFAppHeight/667.0;
}

// 5.5寸屏幕为基准的适配比例
+ (float)screenMultipleIn6p
{
    // iPhone X 和 Plus 同宽度, 高度更高, 所以适配同 Plus
    if ([JFDeviceInfo isIPhoneXSize]) {
        return 667.0/736.0;
    }
    return kJFAppHeight/736.0;
}

// 判断设备
+ (BOOL)isIPhone4Size
{
    return kJFAppHeight == 480.0 ? YES : NO;
}

+(BOOL)isIPhone5Size
{
    return kJFAppHeight == 568.0 ? YES : NO;
}

+(BOOL)isIPhone6Size
{
    return kJFAppHeight == 667.0 ? YES : NO;
}

+(BOOL)isIPhone6PSize
{
    return kJFAppHeight == 736.0 ? YES : NO;
}

+ (BOOL)isIPhoneXSize
{
    return kJFAppHeight == 812.0 ? YES : NO;
}

// 调用电话功能拨打电话
+ (void)callPhoneWithPhoneNumber:(NSString *)phoneNumber
{
    if ([phoneNumber isEqualToString:@""]) {
#ifdef DEBUG
        NSAssert(NO, @"empty number string!");
#endif
        return;
    }
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
    NSComparisonResult compare = [[UIDevice currentDevice].systemVersion compare:@"10.0"];
    if (compare == NSOrderedDescending || compare == NSOrderedSame) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

#pragma mark -相机、相册权限
+ (BOOL)isGetCameraPermission
{
    BOOL isCameraValid = YES;
    //ios7之前系统默认拥有权限
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusDenied)
            {
            isCameraValid = NO;
            }
        }
    return isCameraValid;
}


+ (BOOL)isGetPhotoPermission
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
        {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        
        if ( author == ALAuthorizationStatusDenied ) {
            
            return NO;
        }
        return YES;
        }
    
    PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
    if ( authorStatus == PHAuthorizationStatusDenied ) {
        
        return NO;
    }
    return YES;
}

+ (BOOL)isGetLocationPermission
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        
        //定位功能可用
        return YES;
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        
        //定位不能用
        return NO;
    }
    return NO;
}

#pragma mark - 设备控制
+ (void)setLockScreen:(BOOL)isLock
{
    [UIApplication sharedApplication].idleTimerDisabled = isLock;
}

#pragma mark - Getter

// 当前系统版本
+ (NSInteger)getCurrentOSVersion
{
    NSInteger version;
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (systemVersion >= 11.0) {
        version = kJFSystem_iOS_11;
    }
    else if (systemVersion >= 10.0) {
        version = kJFSystem_iOS_10;
    }
    else if (systemVersion >= 9.0) {
        version = kJFSystem_iOS_9;
    }
    else if (systemVersion >= 8.0) {
        version = kJFSystem_iOS_8;
    }
    else if (systemVersion >= 7.0) {
        version = kJFSystem_iOS_7;
    }
    else {
        version = kJFSystem_iOS_6;
    }
    
    return version;
}

// 当前 APP 版本
+ (NSString *)getCurrentAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSInteger)getCurrentAppBuildVersion
{
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] integerValue];
}
@end
