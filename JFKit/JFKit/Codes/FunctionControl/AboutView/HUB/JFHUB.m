//
//  JFHUB.m
//  JFKit
//
//  Created by joyFate on 2017/5/8.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "JFHUB.h"
#import <MBProgressHUD.h>
#import "JFDeviceInfo.h"

@interface JFHUB ()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIWindow *showView;

@end

@implementation JFHUB

SingletonM(JFHUB)

- (void)showImage:(NSString *)name time:(NSTimeInterval)time message:(NSString *)message {
    
    if (self.hud != nil) {
        [self.hud hide:YES];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.customView ? self.customView : self.showView animated:YES];
    
    // Set the custom view mode to show any view.
    self.hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    self.hud.square = YES;
    // Optional label text.
    self.hud.labelText = message;
    self.hud.margin = 20.f;
    self.hud.opacity = 0.7;
    self.hud.cornerRadius = 4;
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud hide:YES afterDelay:time];
}

- (void)showMessage:(NSString *)message {
    [self showMessage:message time:1.f];
}

- (void)showMessage:(NSString *)message time:(NSTimeInterval)time {
    
    if (self.hud != nil) {
        [self.hud hide:YES];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.customView ? self.customView : self.showView
                                    animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = message;
    self.hud.labelFont = [UIFont systemFontOfSize:14];
    //self.hud.yOffset = -(WIDTH_SCREEN / 2 - HEIGHT_NAVBAR - 30);
    self.hud.margin = 15.f;
    self.hud.opacity = 0.7;
    self.hud.cornerRadius = 4;
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud hide:YES afterDelay:time];
}

- (void)showMessage:(NSString *)message time:(NSTimeInterval)time view:(UIView *)view {
    
    if (self.hud != nil) {
        [self.hud hide:YES];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = message;
    self.hud.labelFont = [UIFont systemFontOfSize:14];
    self.hud.yOffset = -(kJFAppWidth / 2 - kJFAppHeight - 80);
    self.hud.margin = 15.f;
    self.hud.opacity = 0.7;
    self.hud.cornerRadius = 4;
    self.hud.removeFromSuperViewOnHide = YES;
    if(time != 0){
        [self.hud hide:YES afterDelay:time];
    }
}

- (void)showLoadding:(NSString *)message {
    [self showLoadding:message time:0];
}

- (void)showLoadding:(NSString *)message time:(NSTimeInterval)time {
    
    if (self.hud != nil) {
        [self.hud hide:YES];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:self.showView
                                    animated:YES];
    self.hud.labelText = message;
    self.hud.margin = 20.f;
    self.hud.opacity = 0.7;
    self.hud.cornerRadius = 4;
    self.hud.removeFromSuperViewOnHide = YES;
    if(time != 0){
        [self.hud hide:YES afterDelay:time];
    }
}

- (void)showLoadding:(NSString *)message time:(NSTimeInterval)time view:(UIView *)view {
    
    if (self.hud != nil) {
        [self.hud hide:YES];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:view
                                    animated:YES];
    self.hud.labelText = message;
    self.hud.labelFont = [UIFont systemFontOfSize:12];
    self.hud.margin = 8.f;
    self.hud.opacity = 0.7;
    self.hud.cornerRadius = 4;
    self.hud.removeFromSuperViewOnHide = YES;
    if(time != 0){
        [self.hud hide:YES afterDelay:time];
    }
}

- (void)dismissHub
{
    [self.hud hide:YES];
}

#pragma mark - Getter
- (UIView *)showView
{
    if (!_showView) {
        _showView = [UIApplication sharedApplication].keyWindow;
    }
    return _showView;
}

@end
