//
//  JFWebView.m
//  JFKit
//
//  Created by joyFate on 16/7/29.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFWebView.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import "JFHUB.h"

@interface JFWebView () <UIWebViewDelegate>

@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation JFWebView

#pragma mark - Public

- (instancetype)initWithNavController:(UINavigationController *)naviController hasTitleView:(BOOL)hasTitleView titleText:(NSString *)titleText
{
    if (self = [super init]) {
        
        self.navigationController = naviController;
        self.delegate = self;
        self.scalesPageToFit = YES;
    }
    return self;
}

- (void)setCookieWithUrl:(NSURL *)url cookieName:(NSString *)cookieName cookieValue:(NSString *)cookieValue
{
    // 设定 cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                @{[url host]:  NSHTTPCookieDomain,
                                  [url path]:  NSHTTPCookiePath,
                                  cookieName:  NSHTTPCookieName,
                                  cookieValue: NSHTTPCookieValue}];
    
    // 设定 cookie 到 storage 中
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

- (void)removeView
{
    self.delegate = nil;
    [JFProcessHUB dismissHub];
}

#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [JFProcessHUB showLoadding:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [JFProcessHUB dismissHub];
}

#pragma mark - Setter
- (void)setHideScrollBar:(BOOL)hideScrollBar
{
    _hideScrollBar = hideScrollBar;
    
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            // 右侧滚动条隐藏
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:hideScrollBar];
            
            // 左侧滚动条隐藏
            [(UIScrollView *)subView setShowsHorizontalScrollIndicator:hideScrollBar];
            
            for (UIView *inScrollView in [subView subviews]) {
                if ([inScrollView isKindOfClass:[UIImageView class]]) {
                    [inScrollView setHidden:hideScrollBar];     // 上下滚动出边界时的黑色的图片
                }
            }
        }
    }
}

- (void)setHtmlURL:(NSString *)htmlURL
{
    _htmlURL = [htmlURL stringByAddingPercentEscapesUsingEncoding:NSUnicodeStringEncoding];
    
    NSURL *url = [NSURL URLWithString:_htmlURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self loadRequest:request];
}

@end
